Partial Public Class WebForm1
    Inherits System.Web.UI.Page
    Dim TipoCambio As Decimal = 0
    Const TasaIva As Double = 0.35
    Dim TasaVidaMes As Double = 1
    Dim TasaVidaDia As Double = TasaVidaMes / 30.4
    Dim TasaVidaAnual As Double = TasaVidaMes * 12
    Dim TasaAnual As Double = 0
    Dim TasaAnualIva As Double = 0.0 * (1 + TasaIva)
    Dim Bandera As Boolean = False
    Dim Cat As String
    Dim ContRecur As Double = 0
    Dim FinDeMes As Boolean = False

    Dim CapitaT As Double = 0
    Dim PagoT As Double = 0
    Dim InteresT As Double = 0
    Dim IvaT As Double = 0
    Dim SegT As Double = 0
    Dim TotalT As Double = 0
    Dim Diferencia As Double = 0
    Dim DiasT As Double = 0
    Dim PagoS() As Double

    Private Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        TxtTasa.Text = (TasaIva * 100).ToString("n2")
        TipoCambio = SacaTipoCambio()
        TxtTC.Text = TipoCambio
        For x As Integer = 85 To 1 Step -1
            CmbPorcCRE.Items.Add(x)
        Next
    End Sub

    Private Sub Page_InitComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.InitComplete
        CbmTipo_SelectedIndexChanged(Nothing, Nothing)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Master.Titulo = "Cotizador Alliance-Australia"
    End Sub

    Protected Sub BotonEnviar1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BotonEnviar1.Click
        LbError.Text = "Monto finanaciado no válido."
        If IsNumeric(TxtMonto.Text) = False Then
            LbError.Visible = True
            Exit Sub
        Else
            If CDec(TxtMontoCli.Text) <= 0 Then
                LbError.Visible = True
                Exit Sub
            End If
        End If
        LbError.Visible = False
        CalculaTabla()
    End Sub

    Sub CalculaTabla()
        Dim TAmortizaciones As New ProDS.TablaAmortizacionDataTable
        Dim NoPagos As Integer = 0
        Dim NoPagosAnual As Integer = 0
        Dim Capital As Double = CDbl(TxtMontoCli.Text).ToString("N2")
        Dim CapitalSEG As Double = CDbl(TxtMontoCli.Text).ToString("N2")
        Dim MesSeguro As String = ""
        Dim FechaAux As Date = Date.Now.AddMonths(1)
        Dim FechaFin As Date = Date.Now.AddMonths(1)
        Dim SegVidaX As Double = TasaVidaDia
        Dim ErrorEnero As Date = Date.Now.AddMonths(1)
        TasaAnual = CDbl(TxtTasa.Text) / 100


        Dim Meses As Integer = CmbPlazo.SelectedValue

        FechaFin = FechaAux.AddMonths(Meses)
        NoPagos = Meses
        NoPagosAnual = 12


        Dim FechaAnt As Date = Date.Now
        Dim Cont As Integer = 0
        Dim Dias As Double = 0
        Dim DiasX As Double = 0
        Dim Interes As Double = 0

        Dim PagoX As Double = 0
        Dim PagoY As Double = 0
        Dim Extra As Double = 0
        Dim Aux As Double = 0
        Dim rr As ProDS.TablaAmortizacionRow
        Dim rrr As ProDS.TablaAmortizacionRow

        TAmortizaciones.Rows.Clear()
        MesSeguro = FechaAux.ToString("yyyyMM")

        While FechaAux < FechaFin.ToShortDateString
            Cont += 1
            If Cont = 1 Then
                If FechaAux.AddDays(1).Day = 1 And FechaAux.Month <> 2 Then
                    FinDeMes = True
                Else
                    FinDeMes = False
                End If
            End If
            If Cont = 2 Then
                Aux = CDbl(TAmortizaciones.Rows(0).Item("Interes"))
                Capital = (CDbl(TxtMontoCli.Text) - (PagoY - Aux)).ToString("N2")
            End If
            Dias = DateDiff(DateInterval.Day, FechaAnt, FechaAux)
            Interes = (Capital * (TasaAnual / 360) * Dias).ToString("N2")
            rr = TAmortizaciones.NewRow
            rr.No_Pago = Cont
            rr.Fecha_Vencimiento = FechaAux.ToShortDateString
            rr.Dias = Dias 'DIAS
            If Cont = 1 Then
                DiasX = DateDiff(DateInterval.Day, FechaAnt, FechaAnt.AddMonths(CmbPlazo.SelectedValue))
                PagoX = Pmt((TasaAnual / 360) * Dias, NoPagos, Capital * -1, 0, DueDate.EndOfPeriod)
                PagoY = Pmt((TasaAnual / 360) * Dias, NoPagos, Capital * -1, 0, DueDate.EndOfPeriod)
            Else

                If Cont = 2 Then 'CORRIGE PRIMERA AMORTIZACION POR DIFERENCIA 
                    rrr = TAmortizaciones.Rows(0)
                    Aux = (PagoX - CDbl(rrr.Iva_Interes)).ToString("N2")
                    Capital = CDbl(TxtMontoCli.Text) - Aux
                    PagoX = Pmt((TasaAnual / 360) * Dias, NoPagos - (Cont - 1), Capital * -1, 0, DueDate.EndOfPeriod).ToString("N2")
                    Interes = (Capital * (TasaAnual / 360) * Dias).ToString("N2")
                    TAmortizaciones.Rows(0).Item("Capital") = PagoX.ToString("N2") - rrr.Interes ' CAPITAL
                    TAmortizaciones.Rows(0).Item("Pago") = PagoX.ToString("N2")
                    Capital += Aux - (rrr.Capital)
                    TAmortizaciones.Rows(0).Item("Pago Total") = (CDec(rrr.Iva_Interes) + CDec(rrr.Pago) + CDec(rrr.Seguro_de_Vida)).ToString("n2")
                End If
            End If

            rr.Saldo_Insoluto = Capital.ToString("N2")
            rr.Interes = Interes.ToString("N2") ' INTERES
            If NoPagos = Cont Then
                rr.Capital = Capital.ToString("N2") ' CAPITAL
                rr.Pago = (Capital + Interes).ToString("N2")
                PagoX = (Capital + Interes)
            Else
                rr.Capital = (PagoX - Interes).ToString("N2") ' CAPITAL
                rr.Pago = PagoX.ToString("N2")
            End If


            If MesSeguro <> FechaAux.ToString("yyyyMM") Then
                CapitalSEG = Capital
            End If
            MesSeguro = FechaAux.ToString("yyyyMM")



            rr.Iva_Interes = (Interes * TasaIva).ToString("N2")
            rr.Seguro_de_Vida = (((Capital + Interes) / 1000) * SegVidaX * Dias).ToString("N2")
            rr.Pago_Total = ((((Capital + Interes) / 1000) * SegVidaX * Dias) + (Interes * TasaIva) + PagoX).ToString("N2")

            Capital = Capital.ToString("N2") - (PagoX.ToString("N2") - Interes.ToString("N2"))

            FechaAnt = FechaAux

            If FinDeMes = False Then
                FechaAux = FechaAnt.AddMonths(1)
                If Cont = 2 And FechaAnt.Month = 2 And FechaAnt.AddDays(1).Day = 1 Then
                    If ErrorEnero.Day = 29 And FechaAux.Day = 28 Then FechaAux = FechaAux.AddDays(1)
                    If ErrorEnero.Day = 30 And FechaAux.Day = 28 Then FechaAux = FechaAux.AddDays(2)
                    If ErrorEnero.Day = 30 And FechaAux.Day = 29 Then FechaAux = FechaAux.AddDays(1)
                End If
            Else
                FechaAux = FechaAnt.AddDays(1)
                FechaAux = FechaAux.AddMonths(1)
                FechaAux = FechaAux.AddDays(-1)
            End If

            If Cont = 1 Then
                If rr.Capital < 0 Then
                    Response.Write("Primera amortizacion Menor a cero, reconsidere las fecha de contratacion.")
                    TAmortizaciones.Rows.Clear()
                    Exit Sub
                End If
            End If
            TAmortizaciones.AddTablaAmortizacionRow(rr)
        End While


        CapitaT = 0
        PagoT = 0
        InteresT = 0
        IvaT = 0
        SegT = 0
        TotalT = 0
        Diferencia = 0
        DiasT = 0
        ReDim PagoS(NoPagos)
        Cont = 0
        PagoS(0) = CDbl(TxtMontoCli.Text) * -1
        For Each rr In TAmortizaciones.Rows
            Cont += 1
            PagoS(Cont) = CDbl(rr.Pago_Total) - CDbl(rr.Iva_Interes)
            Capital = CDbl(rr.Capital)
            CapitaT += Capital
            PagoT = PagoT + CDbl(rr.Pago)
            DiasT = DiasT + CDbl(rr.Dias)
            InteresT = InteresT + CDbl(rr.Interes)
            IvaT = IvaT + CDbl(rr.Iva_Interes)
            SegT = SegT + CDbl(rr.Seguro_de_Vida)
            TotalT = TotalT + CDbl(rr.Pago_Total)
        Next
        GridAmortizaciones.DataSource = TAmortizaciones
        GridAmortizaciones.DataBind()


        If GridAmortizaciones.Rows.Count > 0 Then
            Dim TIR As Double = IRR(PagoS, 0.01)
            Cat = Math.Round((((1 + (TIR)) ^ NoPagosAnual) - 1), 3).ToString("p1")
            'LbAjuste.Text = "CAT: " & Cat & "  Ajuste: " & Diferencia.ToString
        End If

    End Sub

    Private Sub GridAmortizaciones_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridAmortizaciones.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Cells(1).Text = CDate(e.Row.Cells(1).Text).ToShortDateString()
            e.Row.Cells(3).Text = CDec(e.Row.Cells(3).Text).ToString("N2")
            e.Row.Cells(4).Text = CDec(e.Row.Cells(4).Text).ToString("N2")
            e.Row.Cells(5).Text = CDec(e.Row.Cells(5).Text).ToString("N2")
            e.Row.Cells(6).Text = CDec(e.Row.Cells(6).Text).ToString("N2")
            e.Row.Cells(7).Text = CDec(e.Row.Cells(7).Text).ToString("N2")
            e.Row.Cells(8).Text = CDec(e.Row.Cells(8).Text).ToString("N2")
            e.Row.Cells(9).Text = CDec(e.Row.Cells(9).Text).ToString("N2")
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(2).Text = DiasT
            e.Row.Cells(4).Text = CapitaT.ToString("n2")
            e.Row.Cells(5).Text = InteresT.ToString("n2")
            e.Row.Cells(6).Text = PagoT.ToString("n2")
            e.Row.Cells(7).Text = IvaT.ToString("n2")
            e.Row.Cells(8).Text = SegT.ToString("n2")
            e.Row.Cells(9).Text = TotalT.ToString("n2")
        End If

    End Sub

    Protected Sub CbmTipo_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CbmTipo.SelectedIndexChanged
        If CbmTipo.SelectedValue = 1 Then
            TxtUSD.Text = "3,200.00"
            CmbPorcCRE.Text = "85"
        Else
            TxtUSD.Text = "3,200.00"
            CmbPorcCRE.Text = "85"
        End If
        CalculaMontos()
    End Sub

    Function SacaTipoCambio() As Decimal
        Dim ta As New Factor100DSTableAdapters.TipoCambioTableAdapter
        Dim t As New Factor100DS.TipoCambioDataTable
        Dim r As Factor100DS.TipoCambioRow
        ta.Fill(t)
        r = t.Rows(0)
        ta.Dispose()
        t.Dispose()
        Return r.TC
    End Function

    Protected Sub CmbPorcCRE_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CmbPorcCRE.SelectedIndexChanged
        Calculamontos()
    End Sub

    Sub CalculaMontos()
        TxtUSDcli.Text = (CDec(TxtUSD.Text) * (CDec(CmbPorcCRE.Text) / 100)).ToString("n2")
        TxtMontoCli.Text = (CDec(TxtUSDcli.Text) * TipoCambio).ToString("n2")
        TxtMonto.Text = (CDec(TxtUSD.Text) * TipoCambio).ToString("n2")
        TxtAport.Text = (CDec(TxtMonto.Text) - CDec(TxtMontoCli.Text)).ToString("n2")
    End Sub
End Class