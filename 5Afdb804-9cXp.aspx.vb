Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Public Class CPXFormMC
    Inherits System.Web.UI.Page
    Dim taOBS As New ProDSTableAdapters.CXP_ObservacionesSolicitudTableAdapter

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Label1.Text = My.Settings.RUTA_TMP
            If Not IsNothing(Request("User")) Then
                Session.Item("User") = Request("User")
                Response.Redirect("~\5Afdb804-9cXp.aspx")
            End If
            If IsNothing(Session("User")) Then
                Panel1.Visible = False
                LbError.Visible = True
            Else
                Dim ta As New CXP_DSTableAdapters.Vw_PagosFactor100TableAdapter
                Dim t As New CXP_DS.Vw_PagosFactor100DataTable
                ta.UpdateMoneda()
                ta.Fill(t, Session("User"))
                Dim R As CXP_DS.Vw_PagosFactor100Row
                If t.Rows.Count > 0 Then
                    R = t.Rows(0)
                    If Session("ID1") > "0" Then
                        Panel1.Visible = True
                        If Not IsNothing(Session("ID4")) Then
                            GridView1.SelectedIndex = Session("ID4")
                        End If
                    Else
                        Panel1.Visible = False
                    End If
                    LbError.Visible = False
                Else
                    Panel1.Visible = False
                    LbError.Visible = True
                End If
            End If
        Catch ex As Exception
            Panel1.Visible = False
            LbError.Visible = True
        End Try
    End Sub

    Protected Sub BotonAutorizar_Click(sender As Object, e As EventArgs) Handles BotonAutorizar.Click
        Dim ta As New CXP_DSTableAdapters.Vw_PagosFactor100TableAdapter
        Dim t As New CXP_DS.Vw_PagosFactor100DataTable
        Dim r As CXP_DS.Vw_PagosFactor100Row
        Dim Firma As String = Encriptar(Date.Now.ToString("yyyyMMddhhmm") & Session("User") & Session("ID1") & "-" & Session("ID2"))
        Dim Mensaje As String = ""
        Dim Asunto As String = ""

        ta.FillByID(t, Session("ID1"))
        r = t.Rows(0)

        Mensaje = "Solicitud: " & r.referencia & "<br>"
        Mensaje += "Beneficiario: " & r.NOMBRE & "<br>"
        Mensaje += "Importe: " & CDec(r.importe).ToString("n2") & "<br>"
        Mensaje += "Autorizó: " & Session("User") & "<br>"
        Mensaje += "Comentario: " & TextMail.Text & "<br>"
        Asunto = "Solicitud de Pagos Autorizada (" & r.NOMBRE & "): " & Session("ID1")

        LbError.Text = "Pago Autorizado"
        Panel1.Visible = False
        LbError.Visible = True

        MandaCorreoFase("Pagos@finagil.com.mx", "FactorCXP", Asunto, Mensaje)
        MandaCorreoFase("Pagos@finagil.com.mx", "SISTEMAS_CXP", Asunto, Mensaje)
        ta.UpdateEstatus("AutorizadoMC", Session("ID1"))
        Session("ID1") = 0
        Session("ID4") = Nothing

        Response.Redirect("~\5Afdb804-9cXp.aspx", True)
    End Sub

    Protected Sub BotonRechazar_Click(sender As Object, e As EventArgs) Handles BotonRechazar.Click
        Dim ta As New CXP_DSTableAdapters.Vw_PagosFactor100TableAdapter
        Dim t As New CXP_DS.Vw_PagosFactor100DataTable
        Dim r As CXP_DS.Vw_PagosFactor100Row
        Dim Mensaje As String = ""
        Dim Asunto As String = ""
        ta.FillByID(t, Session("ID1"))
        r = t.Rows(0)
        Mensaje = "Solicitud: " & r.referencia & "<br>"
        Mensaje += "Beneficiario: " & r.NOMBRE & "<br>"
        Mensaje += "Importe: " & CDec(r.importe).ToString("n2") & "<br>"
        Mensaje += "Rechazó: " & Session("User") & "<br>"
        Mensaje += "Comentario: " & TextMail.Text & "<br>"
        Asunto = "Solicitud de Pagos Rechazada (" & r.NOMBRE & "): " & Session("ID1")

        LbError.Text = "Pago Rechazado"
        Panel1.Visible = False
        LbError.Visible = True

        If TextMail.Text.Length <= 0 Then
            TextMail.Text = "RECHAZADO"
        Else
            TextMail.Text = "RECHAZADO - " & TextMail.Text
        End If

        MandaCorreoFase("Pagos@finagil.com.mx", "FactorCXP", Asunto, Mensaje)
        MandaCorreoFase("Pagos@finagil.com.mx", "SISTEMAS_CXP", Asunto, Mensaje)
        ta.UpdateEstatus("Rechazado", Session("ID1"))
        Session("ID1") = 0
        Session("ID4") = Nothing
        Response.Redirect("~\5Afdb804-9cXp.aspx", True)
    End Sub

    Protected Sub BotonCorreo_Click(sender As Object, e As EventArgs) Handles BotonCorreo.Click
        Dim ta As New CXP_DSTableAdapters.Vw_PagosFactor100TableAdapter
        Dim t As New CXP_DS.Vw_PagosFactor100DataTable
        Dim r As CXP_DS.Vw_PagosFactor100Row
        Dim Mensaje As String = ""
        Dim Asunto As String = ""
        Dim Archivo As String
        ta.FillByID(t, Session("ID1"))
        r = t.Rows(0)
        Mensaje = "Solicitud: " & r.referencia & "<br>"
        Mensaje += "Beneficiario: " & r.NOMBRE & "<br>"
        Mensaje += "Importe: " & CDec(r.importe).ToString("n2") & "<br>"

        If TextMail.Text.Length <= 0 Then
            Exit Sub
        End If
        LbError.Text = "Correo Enviado"
        Panel1.Visible = False
        LbError.Visible = True
        Mensaje += "Comentario: " & TextMail.Text & "<br>"
        Asunto = "Comentarios de Pagos de Factoraje (" & r.NOMBRE & "): " & Session("ID1")
        TextMail.Text = ""

        MandaCorreoFase("Pagos@finagil.com.mx", "FactorCXP", Asunto, Mensaje)
        MandaCorreoFase("Pagos@finagil.com.mx", "SISTEMAS_CXP", Asunto, Mensaje)
        Session("ID1") = 0
        Session("ID4") = Nothing
        Response.Redirect("~\5Afdb804-9cXp.aspx", True)
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView1.SelectedIndexChanged
        Session("ID1") = GridView1.SelectedDataKey("id")
        Session("ID4") = GridView1.SelectedIndex
        Response.Redirect("~\5Afdb804-9cXp.aspx", True)
    End Sub


End Class