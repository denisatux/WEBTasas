Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Data
Imports System.Net
Imports System.Text
Imports System.IO
Imports System.Web.Script.Serialization

Public Class contact_form
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.Form.Count > 0 Then
            Dim Aux As String = Request.Form.Item("g-Recaptcha-Response")
            Aux = VerifyCaptcha(Aux)
            Dim Mensaje As String = ""
            If InStr(Aux, ": true") > 0 Then
                Mensaje = "Nombre: " & Request.Form.Item("name").ToUpper
                Mensaje += "<br>Correo: " & Request.Form.Item("email").ToUpper
                Mensaje += "<br>Mensaje: " & Request.Form.Item("message").ToUpper

                MandaCorreoFase("WebFinagil@finagil.com.mx", "sistemas", Request.Form.Item("subject"), Mensaje)
                MandaCorreoFase("WebFinagil@finagil.com.mx", "DG", Request.Form.Item("subject"), Mensaje)
                Label1.Text = ("Gracias " & Request.Form.Item("name").ToUpper & " tu mensaje ha sido enviado. En breve te responderemos.")
            Else
                Label1.Text = ("Favor de indicar que no es un robot")
            End If
        Else
            Label1.Text = ("Error de Envio")
        End If
    End Sub

    Public Shared Function VerifyCaptcha(response As String) As String
        Dim ReCaptcha_Secret As String = "6Leix7wUAAAAAGK3FOhRuZ5keRaAehvU9iP1DxzC"
        Dim url As String = "https://www.google.com/recaptcha/api/siteverify?secret=" & ReCaptcha_Secret & "&response=" & response
        Return (New WebClient()).DownloadString(url)
    End Function

End Class