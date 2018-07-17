Partial Public Class HC_Form1
    Inherits System.Web.UI.Page
    Dim Tipo As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsNothing(Request("User")) Then
            Panel1.Visible = False
            LbError.Visible = True
        Else
            Dim ta As New ProDSTableAdapters.HojaCambiosTableAdapter
            Dim Correos As New SeguridadDSTableAdapters.UsuariosFinagilTableAdapter
            Dim t As New ProDS.HojaCambiosDataTable
            ta.Fill_User(t, Request("User"))
            If t.Rows.Count > 0 Then
                If Request("ID") = 0 Then
                    Panel1.Visible = True
                    LbError.Visible = False
                    BotonEnviar1.Visible = False
                    BotonEnviar1.Text = "Autorizar"
                    BotonEnviar1.TextoEnviando = "Autorizar..."
                Else
                    Panel1.Visible = True
                    LbError.Visible = False
                    BotonEnviar1.Text = "Autorizar"
                    BotonEnviar1.TextoEnviando = "Autorizar..."
                    BotonEnviar1.Visible = True
                End If
            Else
                Panel1.Visible = False
                LbError.Visible = True
            End If
        End If
    End Sub

    Protected Sub BotonEnviar1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BotonEnviar1.Click
        Dim ta As New ProDSTableAdapters.MC_cambio_condicionesTableAdapter
        Dim Firma As String = Encriptar(Date.Now.ToString("yyyyMMddhhmm") & "-" & Request("User"))
        If Request("User").ToLower = "gbello" Then
            ta.FirmaDG(Firma, Date.Now, Request("ID"))
            If ta.PromotorHC(Request("ID")) = "033" Then 'Rosalba MAyorga depende de DG
                ta.FirmaSubPromo(Firma, Request("ID"))
            End If
        Else
                ta.FirmaSubPromo(Firma, Request("ID"))
        End If
        Response.Redirect("~\5159dx1-HCaut.aspx?User=" & Request("User") & "&Anexo=0&ID=0")
    End Sub


End Class