Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Public Class CPXForm
    Inherits System.Web.UI.Page
    Dim taOBS As New ProDSTableAdapters.CXP_ObservacionesSolicitudTableAdapter
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            LbAutorizante.Visible = False
            ListAutorizante.Visible = False
            If Request("User").Length <= 0 Then
                Panel1.Visible = False
                LbError.Visible = True
            Else
                Dim ta As New ProDSTableAdapters.Vw_CXP_AutorizacionesTableAdapter
                Dim t As New ProDS.Vw_CXP_AutorizacionesDataTable
                ta.Fill(t, Request("User"))
                Dim R As ProDS.Vw_CXP_AutorizacionesRow
                If t.Rows.Count > 0 Then
                    If InStr(Request("User"), "lmercado") > 0 Then
                        LbAutorizante.Visible = True
                        ListAutorizante.Visible = True
                    End If
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

    Sub GeneraArchivo(Archivo As String, Empresa As Decimal, FirmaSol As String, Solicitud As Decimal, Estatus As String, Serie As String, Contrato As Boolean)
        Dim ta As New ProDSTableAdapters.Vw_CXP_AutorizacionesRPTTableAdapter
        Dim ds As New ProDS
        Dim rptSolPago As Object
        ta.Fill(ds.Vw_CXP_AutorizacionesRPT, Empresa, Solicitud, Estatus)
        taOBS.Fill(ds.CXP_ObservacionesSolicitud, Empresa, Solicitud)

        If Serie = "PSC" Then
            rptSolPago = New rptSolicitudDePagoSCC
        Else
            rptSolPago = New rptSolicitudDePago
        End If

        rptSolPago.SetDataSource(ds)
        rptSolPago.Subreports(0).SetDataSource(ds)
        rptSolPago.SetParameterValue("var_genero", FirmaSol)
        rptSolPago.SetParameterValue("var_observaciones", ds.CXP_ObservacionesSolicitud.Rows.Count.ToString)
        rptSolPago.SetParameterValue("var_contrato", Contrato)
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
        LbError.Text = "Pagos Autorizados"
        Panel1.Visible = False
        LbError.Visible = True
        Mensaje += "Autorizó: " & r.Autorizante & "<br>"
        Mensaje += "Comentario: " & TextMail.Text & "<br>"
        Asunto = "Solicitud de Pagos Autorizada (" & r.NombreCorto & "): " & Request("ID2")

        If TextMail.Text.Length > 0 Then
            taOBS.Borrar(r.idEmpresa, r.Solicitud, Request("User"))
            taOBS.Insert(r.idEmpresa, r.Solicitud, Request("User"), TextMail.Text)
        End If
        If InStr(Request("User"), "lmercado") > 0 Then
            If ListAutorizante.SelectedValue = "DG" Then
                ta.CambiaAutorizante2("#gbello@finagil.com.mx", "C.P. GABRIEL BELLO HERNANDEZ", Request("ID2"), Request("ID1"), Request("ID3"))
            ElseIf ListAutorizante.SelectedValue = "DO" Then
                ta.CambiaAutorizante2("#epineda@finagil.com.mx", "C.P. ELISANDER PINEDA ROJAS", Request("ID2"), Request("ID1"), Request("ID3"))
            End If
        End If
        GeneraArchivo(Archivo, Request("ID1"), Firma2, r.Solicitud, r.Estatus, r.serie, r.contrato)

        MandaCorreo("Pagos@finagil.com.mx", r.MailSolicitante, Asunto, Mensaje, Archivo)
        MandaCorreoFase("Pagos@finagil.com.mx", "SISTEMAS", Asunto, Mensaje, Archivo)
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
        LbError.Text = "Pagos Rechazados"
        Panel1.Visible = False
        LbError.Visible = True
        Mensaje += "Rechazó: " & r.Autorizante & "<br>"
        Mensaje += "Comentario: " & TextMail.Text & "<br>"
        Asunto = "Solicitud de Pagos Rechazada (" & r.NombreCorto & "): " & Request("ID2")
        If TextMail.Text.Length <= 0 Then
            TextMail.Text = "RECHAZADO"
        Else
            TextMail.Text = "RECHAZADO" & TextMail.Text
        End If
        taOBS.Borrar(r.idEmpresa, r.Solicitud, Request("User"))
        taOBS.Insert(r.idEmpresa, r.Solicitud, Request("User"), TextMail.Text)
        GeneraArchivo(Archivo, Request("ID1"), Firma2, r.Solicitud, r.Estatus, r.serie, r.contrato)

        MandaCorreo("Pagos@finagil.com.mx", r.MailSolicitante, Asunto, Mensaje, Archivo)
        MandaCorreoFase("Pagos@finagil.com.mx", "SISTEMAS", Asunto, Mensaje, Archivo)
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
        Asunto = "Comentarios de Pagos y Facturas (" & r.NombreCorto & "): " & Request("ID2")
        TextMail.Text = ""

        MandaCorreo("Pagos@finagil.com.mx", r.MailSolicitante, Asunto, Mensaje, Archivo)
        MandaCorreoFase("Pagos@finagil.com.mx", "SISTEMAS", Asunto, Mensaje, Archivo)
        Response.Redirect("~\5Afdb804-7cXp.aspx?User=" & Request("User") & "&ID1=" & Request("ID") & "&ID2=" & Request("ID") & "&ID3=" & Request("ID"))
    End Sub


End Class