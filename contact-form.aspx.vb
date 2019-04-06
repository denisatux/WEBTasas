Public Class contact_form
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.Form.Count > 0 Then
            Dim Mensaje As String = ""

            Mensaje = "Nombre: " & Request.Form.Item("name").ToUpper
            Mensaje += "<br>Correo: " & Request.Form.Item("email").ToUpper
            Mensaje += "<br>Mensaje: " & Request.Form.Item("message").ToUpper

            MandaCorreoFase("WebFinagil@finagil.com.mx", "sistemas", Request.Form.Item("subject"), Mensaje)
            Label1.Text = ("Gracias " & Request.Form.Item("name").ToUpper & " tu mensaje ha sido enviado. En breve te responderemos.")
        Else

            Label1.Text = ("Error de Envio")
        End If
    End Sub

End Class