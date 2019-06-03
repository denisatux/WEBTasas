Partial Public Class FRM_IVAautInte
    Inherits System.Web.UI.Page
    'Dim Tipo As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsNothing(Request("User")) Then
            Panel1.Visible = False
            LbError.Visible = True
            GridView1.Visible = False
        Else
            Dim ta As New ProDSTableAdapters.AutorizaIVA_InteresTableAdapter
            Dim Correos As New SeguridadDSTableAdapters.UsuariosFinagilTableAdapter
            Dim t As New ProDS.AutorizaIVA_InteresDataTable
            ta.Fill(t)
            If t.Rows.Count > 0 Then
                If Request("Anexo").Length <> 9 Then
                    Panel1.Visible = False
                    LbError.Visible = False
                Else
                    Panel1.Visible = True
                    LbError.Visible = False
                End If
            Else
                Panel1.Visible = False
                LbError.Visible = True
            End If
        End If
    End Sub

    Protected Sub BotonEnviar1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BotonEnviar1.Click
        Dim ta As New ProDSTableAdapters.AutorizaIVATableAdapter
        ta.AutorizaIVA(Request("User") & "X", True, Request("Anexo"), Request("Ciclo"))
        Response.Redirect("~\5159Inte-IVAaut.aspx?User=" & Request("User"))
    End Sub

    Protected Sub BotonEnviar2_Click(sender As Object, e As EventArgs) Handles BotonEnviar2.Click
        Dim ta As New ProDSTableAdapters.AutorizaIVATableAdapter
        ta.AutorizaIVA(Request("User") & "X", False, Request("Anexo"), Request("Ciclo"))
        Response.Redirect("~\5159Inte-IVAaut.aspx?User=" & Request("User"))
    End Sub
End Class