Partial Public Class CPXForm
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Request("User").Length <= 0 Then
                Panel1.Visible = False
                LbError.Visible = True
            Else
                Dim ta As New ProDSTableAdapters.Vw_CXP_AutorizacionesTableAdapter
                Dim t As New ProDS.Vw_CXP_AutorizacionesDataTable
                ta.Fill(t, Request("User"))
                Dim R As ProDS.Vw_CXP_AutorizacionesRow
                If t.Rows.Count > 0 Then
                    R = t.Rows(0)
                    Panel1.Visible = True
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

    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        Dim ta As New ProDSTableAdapters.Vw_CXP_AutorizacionesTableAdapter
        Dim t As New ProDS.Vw_CXP_AutorizacionesDataTable
        Dim r As ProDS.Vw_CXP_AutorizacionesRow
        Dim Empresa As Decimal = GridView1.DataKeys.Item(e.CommandArgument).Item(0)
        Dim Solicitud As Decimal = GridView1.DataKeys.Item(e.CommandArgument).Item(1)
        Dim Estatus As String = GridView1.DataKeys.Item(e.CommandArgument).Item(2)
        Dim Firma As String = Encriptar(Date.Now.ToString("yyyyMMddhhmm") & Request("User") & Empresa & "-" & Solicitud)
        Dim Mensaje As String = ""
        Dim Asunto As String = ""
        ta.FillByID(t, Solicitud, Empresa, Estatus)
        r = t.Rows(0)
        Mensaje = "Solicitud: " & r.Solicitud & "<br>"
        Mensaje += "Estatus: " & r.Estatus & "<br>"
        Mensaje += "Importe: " & CDec(r.Total).ToString("n2") & "<br>"

        Select Case e.CommandName
            Case "Autorizar"
                ta.Ok1(Firma, Empresa, Solicitud, Request("User"))
                ta.OK2(Firma, Empresa, Solicitud, Request("User"))
                LbError.Text = "Gastos Autorizados"
                Panel1.Visible = False
                LbError.Visible = True
                Mensaje += "Autorizó: " & r.Autorizante & "<br>"
                Asunto = "Solicitud de Gastos Autorizada : " & Solicitud
            Case "Rechazar"
                ta.Ok1("RECHAZADO", Empresa, Solicitud, Request("User"))
                ta.OK2("RECHAZADO", Empresa, Solicitud, Request("User"))
                LbError.Text = "Gastos Rechazados"
                Panel1.Visible = False
                LbError.Visible = True
                Mensaje += "Rechazó: " & r.Autorizante & "<br>"
                Asunto = "Solicitud de Gastos Rechazada : " & Solicitud
            Case "Correo"
                Dim txt As TextBox = GridView1.Rows(e.CommandArgument).FindControl("TextCorreo")
                LbError.Text = "Correo Enviado"
                Panel1.Visible = False
                LbError.Visible = True
                Mensaje += "Comentario: " & txt.Text & "<br>"
                Asunto = "Comentarios de Gastos y Facturas: " & Solicitud
        End Select
        MandaCorreo("Gastos@finagil.com.mx", r.MailSolicitante, Asunto, Mensaje)
        MandaCorreoFase("Gastos@finagil.com.mx", "SISTEMAS", Asunto, Mensaje, "")
        Response.Redirect("~\5Afdb804-7cXp.aspx?User=" & Request("User"))
    End Sub
End Class