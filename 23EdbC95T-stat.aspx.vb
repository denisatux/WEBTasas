Partial Public Class ASPX_Estatus
    Inherits System.Web.UI.Page
    Dim Tipo As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim ta As New ProDSTableAdapters.StatusMinistracionesTableAdapter
        Dim t As New ProDS.StatusMinistracionesDataTable
        ta.Fill(t)
        If t.Rows.Count > 0 Then
            If Request("ID") = 0 Then
                Panel1.Visible = True
                LbError.Visible = False
            Else
                Panel1.Visible = True
                LbError.Visible = False
            End If
        Else
            Panel1.Visible = False
            LbError.Visible = True
        End If
    End Sub

    Protected Sub GridView2_SelectedIndexChanged(sender As Object, e As EventArgs)

    End Sub
End Class