Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Public Class ReestructurasForm
    Inherits System.Web.UI.Page
    Dim Contador As Integer
    Dim ta As New DeyelDSTableAdapters.CasosTotalesNTableAdapter
    Dim ta2 As New DeyelDSTableAdapters.CasosTotalesN2TableAdapter

    Protected Sub GridView1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView1.SelectedIndexChanged
        Session("AREA RESPONSABLE") = GridView1.SelectedDataKey("AREA RESPONSABLE")
    End Sub

    Protected Sub GridView3_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView3.SelectedIndexChanged
        Session("CASO") = GridView3.SelectedDataKey("CLIENTES EN PROCESO")
    End Sub

    Private Sub GridView3_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView3.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Contador += 1
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(1).Text = "TOTAL DE CASOS : " & Contador
            e.Row.HorizontalAlign = HorizontalAlign.Center
            e.Row.Font.Bold = True
        End If
    End Sub

    Private Sub ReestructurasForm_Init(sender As Object, e As EventArgs) Handles Me.Init
        Dim ds As New DeyelDS
        Dim t1 As New DeyelDSTableAdapters.CasosActivosRESUMTableAdapter
        Dim t2 As New DeyelDSTableAdapters.CasosTotalesTableAdapter
        t1.Fill(ds.CasosActivosRESUM)
        t2.Fill(ds.CasosTotales, "%")
        Session("FILTRO") = "%"
        Session("AREA RESPONSABLE") = ds.CasosActivosRESUM.Rows(0).Item("AREA RESPONSABLE")
        Session("CASO") = ds.CasosTotales.Rows(0).Item(0)
        GridView1.SelectedIndex = 0
        GridView3.SelectedIndex = 0

        Dim ds2 As New DeyelDS
        Dim t12 As New DeyelDSTableAdapters.CasosActivosRESUM2TableAdapter
        'Dim t22 As New DeyelDSTableAdapters.CasosTotalesTableAdapter
        t12.Fill(ds2.CasosActivosRESUM2)
        't22.Fill(ds2.CasosTotales, "%")
        Session("FILTRO") = "%"
        Session("AREA RESPONSABLE2") = ds2.CasosActivosRESUM2.Rows(0).Item("AREA RESPONSABLE")
        'Session("CASO2") = ds2.CasosTotales.Rows(0).Item(0)
        GridView7.SelectedIndex = 0


    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Session("FILTRO") = "%" & TextBox1.Text & "%"
    End Sub

    Protected Sub GridView5_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView5.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim EnProceso As Integer = e.Row.Cells(0).Text
            Dim Formalizado As Integer = ta.FormalizadosN
            Dim Rechazo As Integer = ta.RechazadosN
            Dim Totales As Integer = EnProceso + Rechazo + Formalizado
            Dim Avance As Decimal = (Formalizado + Rechazo) / Totales
            e.Row.Cells(1).Text = Formalizado
            e.Row.Cells(2).Text = Rechazo
            e.Row.Cells(3).Text = Totales
            e.Row.Cells(4).Text = Avance.ToString("P2")
        End If
    End Sub

    Protected Sub GridView6_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView6.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim EnProceso As Integer = e.Row.Cells(0).Text
            Dim Formalizado As Integer = ta2.FormalizadosN
            Dim Rechazo As Integer = ta2.RechazadosN
            Dim Totales As Integer = EnProceso + Rechazo + Formalizado
            Dim Avance As Decimal = (Formalizado + Rechazo) / Totales
            e.Row.Cells(1).Text = Formalizado
            e.Row.Cells(2).Text = Rechazo
            e.Row.Cells(3).Text = Totales
            e.Row.Cells(4).Text = Avance.ToString("P2")
        End If
    End Sub

    Protected Sub GridView7_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView7.SelectedIndexChanged
        Session("AREA RESPONSABLE2") = GridView7.SelectedDataKey("AREA RESPONSABLE")
    End Sub
End Class