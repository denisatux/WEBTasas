Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Public Class DeyelCasosForm
    Inherits System.Web.UI.Page
    Dim Contador As Integer

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

    Private Sub DeyelCasosForm_Init(sender As Object, e As EventArgs) Handles Me.Init
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
End Class