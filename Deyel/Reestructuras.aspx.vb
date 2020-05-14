Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Public Class ReestructurasForm
    Inherits System.Web.UI.Page
    Dim Contador As Integer
    Dim ta As New DeyelDSTableAdapters.CasosTotalesNTableAdapter

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

    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Session("FILTRO") = "%" & TextBox1.Text & "%"
    End Sub

    Protected Sub GridView5_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView5.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim cell0 As TableCell = e.Row.Cells(0)
            Dim cell1 As TableCell = e.Row.Cells(1)
            Dim cell2 As TableCell = e.Row.Cells(2)
            Dim EnProceso As Integer = CInt(cell0.Text)
            Dim Terminados As Integer = ta.TerminadosN() + 0.0001
            cell1.Text = Terminados.ToString
            cell2.Text = CDec(Terminados / (Terminados + EnProceso)).ToString("p2")
        End If
    End Sub

End Class