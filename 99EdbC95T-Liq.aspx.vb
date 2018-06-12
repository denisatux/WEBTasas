Partial Public Class ASPX_Liquidez
    Inherits System.Web.UI.Page
    Dim Tipo As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim ta As New ProDSTableAdapters.Vw_RPT_LiquidezTableAdapter
        Dim t As New ProDS.Vw_RPT_LiquidezDataTable
        Dim Empresa As String = Request("Empresa")
        ta.Fill(t, Empresa)
        If t.Rows.Count > 0 Then
            LbError.Visible = False
        Else
            LbError.Visible = True
        End If
    End Sub



End Class