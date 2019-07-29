Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

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
                    If Request("ID1") > "0" Then
                        Panel1.Visible = True
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

    Sub GeneraArchivo(Archivo As String, Empresa As Decimal, FirmaSol As String, Solicitud As Decimal, Estatus As String)
        Dim ta As New ProDSTableAdapters.AutorizacionesRPTTableAdapter
        Dim ds As New ProDS
        Dim rptSolPago As New rptSolicitudDePago
        ta.Fill(ds.AutorizacionesRPT, Empresa, Solicitud, Estatus)
        rptSolPago.SetDataSource(ds)
        rptSolPago.SetParameterValue("var_genero", FirmaSol)
        Select Case Empresa
            Case 23
                rptSolPago.SetParameterValue("var_pathImagen", Server.MapPath("~/IMG/LOGO FINAGIL.JPG"))
            Case 24
                rptSolPago.SetParameterValue("var_pathImagen", Server.MapPath("~/IMG/logoArfin.JPG"))
        End Select
        rptSolPago.ExportToDisk(ExportFormatType.PortableDocFormat, My.Settings.RUTA_TMP & Archivo)
    End Sub

    Protected Sub BotonAutorizar_Click(sender As Object, e As EventArgs) Handles BotonAutorizar.Click
        Dim ta As New ProDSTableAdapters.Vw_CXP_AutorizacionesTableAdapter
        Dim t As New ProDS.Vw_CXP_AutorizacionesDataTable
        Dim r As ProDS.Vw_CXP_AutorizacionesRow
        Dim Firma As String = Encriptar(Date.Now.ToString("yyyyMMddhhmm") & Request("User") & Request("ID1") & "-" & Request("ID2"))
        Dim Mensaje As String = ""
        Dim Asunto As String = ""
        Dim Archivo As String
        ta.FillByID(t, Request("User"), Request("ID2"), Request("ID1"), Request("ID3"))
        r = t.Rows(0)
        Mensaje = "Solicitud: " & r.Solicitud & "<br>"
        Mensaje += "Emrpesa: " & r.NombreCorto & "<br>"
        Mensaje += "Estatus: " & r.Estatus & "<br>"
        Mensaje += "Importe: " & CDec(r.Total).ToString("n2") & "<br>"
        Archivo = "CXP\" & CInt(r.idEmpresa).ToString & "-" & CInt(r.Solicitud).ToString & ".pdf"
        Dim Firma2 As String = Encriptar(r.FechaSol.ToString("yyyyMMddhhmm") & r.MailSolicitante & Request("ID1") & "-" & Request("ID2"))

        ta.Ok1(Firma, Request("ID1"), Request("ID2"), Request("User"))
        ta.OK2(Firma, Request("ID1"), Request("ID2"), Request("User"))
        LbError.Text = "Gastos Autorizados"
        Panel1.Visible = False
        LbError.Visible = True
        Mensaje += "Autorizó: " & r.Autorizante & "<br>"
        Mensaje += "Comentario: " & TextMail.Text & "<br>"
        Asunto = "Solicitud de Gastos Autorizada (" & r.NombreCorto & "): " & Request("ID2")
        GeneraArchivo(Archivo, Request("ID1"), Firma2, r.Solicitud, r.Estatus)

        MandaCorreo("Gastos@finagil.com.mx", r.MailSolicitante, Asunto, Mensaje, Archivo)
        MandaCorreoFase("Gastos@finagil.com.mx", "SISTEMAS", Asunto, Mensaje, Archivo)
        Response.Redirect("~\5Afdb804-7cXp.aspx?User=" & Request("User") & "&ID1=0&ID2=0&ID3=0")
    End Sub

    Protected Sub BotonRechazar_Click(sender As Object, e As EventArgs) Handles BotonRechazar.Click
        Dim ta As New ProDSTableAdapters.Vw_CXP_AutorizacionesTableAdapter
        Dim t As New ProDS.Vw_CXP_AutorizacionesDataTable
        Dim r As ProDS.Vw_CXP_AutorizacionesRow
        Dim Firma As String = Encriptar(Date.Now.ToString("yyyyMMddhhmm") & Request("User") & Request("ID1") & "-" & Request("ID2"))
        Dim Mensaje As String = ""
        Dim Asunto As String = ""
        Dim Archivo As String
        ta.FillByID(t, Request("User"), Request("ID2"), Request("ID1"), Request("ID3"))
        r = t.Rows(0)
        Mensaje = "Solicitud: " & r.Solicitud & "<br>"
        Mensaje += "Emrpesa: " & r.NombreCorto & "<br>"
        Mensaje += "Estatus: " & r.Estatus & "<br>"
        Mensaje += "Importe: " & CDec(r.Total).ToString("n2") & "<br>"
        Archivo = "CXP\" & CInt(r.idEmpresa).ToString & "-" & CInt(r.Solicitud).ToString & ".pdf"
        Dim Firma2 As String = Encriptar(r.FechaSol.ToString("yyyyMMddhhmm") & r.MailSolicitante & Request("ID1") & "-" & Request("ID2"))

        Firma = "RECHAZADO"
        ta.Ok1(Firma, Request("ID1"), Request("ID2"), Request("User"))
        ta.OK2(Firma, Request("ID1"), Request("ID2"), Request("User"))
        LbError.Text = "Gastos Rechazados"
        Panel1.Visible = False
        LbError.Visible = True
        Mensaje += "Rechazó: " & r.Autorizante & "<br>"
        Mensaje += "Comentario: " & TextMail.Text & "<br>"
        Asunto = "Solicitud de Gastos Rechazada (" & r.NombreCorto & "): " & Request("ID2")
        GeneraArchivo(Archivo, Request("ID1"), Firma2, r.Solicitud, r.Estatus)

        MandaCorreo("Gastos@finagil.com.mx", r.MailSolicitante, Asunto, Mensaje, Archivo)
        MandaCorreoFase("Gastos@finagil.com.mx", "SISTEMAS", Asunto, Mensaje, Archivo)
        Response.Redirect("~\5Afdb804-7cXp.aspx?User=" & Request("User") & "&ID1=0&ID2=0&ID3=0")
    End Sub

    Protected Sub BotonCorreo_Click(sender As Object, e As EventArgs) Handles BotonCorreo.Click
        Dim ta As New ProDSTableAdapters.Vw_CXP_AutorizacionesTableAdapter
        Dim t As New ProDS.Vw_CXP_AutorizacionesDataTable
        Dim r As ProDS.Vw_CXP_AutorizacionesRow
        Dim Firma As String = Encriptar(Date.Now.ToString("yyyyMMddhhmm") & Request("User") & Request("ID1") & "-" & Request("ID2"))
        Dim Mensaje As String = ""
        Dim Asunto As String = ""
        Dim Archivo As String
        ta.FillByID(t, Request("User"), Request("ID2"), Request("ID1"), Request("ID3"))
        r = t.Rows(0)
        Mensaje = "Solicitud: " & r.Solicitud & "<br>"
        Mensaje += "Emrpesa: " & r.NombreCorto & "<br>"
        Mensaje += "Estatus: " & r.Estatus & "<br>"
        Mensaje += "Importe: " & CDec(r.Total).ToString("n2") & "<br>"
        Archivo = "CXP\" & CInt(r.idEmpresa).ToString & "-" & CInt(r.Solicitud).ToString & ".pdf"
        Dim Firma2 As String = Encriptar(r.FechaSol.ToString("yyyyMMddhhmm") & r.MailSolicitante & Request("ID1") & "-" & Request("ID2"))

        If TextMail.Text.Length <= 0 Then
            Exit Sub
        End If
        LbError.Text = "Correo Enviado"
        Panel1.Visible = False
        LbError.Visible = True
        Mensaje += "Comentario: " & TextMail.Text & "<br>"
        Asunto = "Comentarios de Gastos y Facturas (" & r.NombreCorto & "): " & Request("ID2")

        MandaCorreo("Gastos@finagil.com.mx", r.MailSolicitante, Asunto, Mensaje, Archivo)
        MandaCorreoFase("Gastos@finagil.com.mx", "SISTEMAS", Asunto, Mensaje, Archivo)
        Response.Redirect("~\5Afdb804-7cXp.aspx?User=" & Request("User") & "&ID1=" & Request("ID") & "&ID2=" & Request("ID") & "&ID3=" & Request("ID"))
    End Sub
End Class