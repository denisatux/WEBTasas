Partial Public Class SUBSucursalForm
    Inherits System.Web.UI.Page
    Dim Tipo As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsNothing(Request("User")) Then
            Panel1.Visible = False
            LbError.Visible = True
        Else
            Dim ta As New ProDSTableAdapters.AvioVoboTableAdapter
            Dim Correos As New SeguridadDSTableAdapters.UsuariosFinagilTableAdapter
            Dim t As New ProDS.AvioVoboDataTable
            ta.FillBySUB(t, Request("User"))
            If t.Rows.Count > 0 Then
                If Request("ID") = 0 Then
                    Panel1.Visible = True
                    LbError.Visible = False
                    BotonEnviar1.Visible = False
                    BotonEnviar1.Text = "Dar Vobo"
                    BotonEnviar1.TextoEnviando = "Dar Vobo"
                Else
                    Panel1.Visible = True
                    LbError.Visible = False
                    BotonEnviar1.Text = "Dar Vobo"
                    BotonEnviar1.TextoEnviando = "Dar Vobo"
                    BotonEnviar1.Visible = True
                End If
            Else
                Panel1.Visible = False
                LbError.Visible = True
            End If
        End If
    End Sub

    Protected Sub BotonEnviar1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BotonEnviar1.Click
        Dim ta As New ProDSTableAdapters.AvioVoboTableAdapter
        ta.DarVoboSUB("DG", Request("Anexo"), Request("ID"))
        Response.Redirect("~\232db951-Suba.aspx?User=" & Request("User") & "&Anexo=0&ID=0")
    End Sub


End Class