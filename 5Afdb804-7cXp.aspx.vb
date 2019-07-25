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
        Dim Archivo As String
        ta.FillByID(t, Solicitud, Empresa, Estatus)
        r = t.Rows(0)
        Mensaje = "Solicitud: " & r.Solicitud & "<br>"
        Mensaje += "Estatus: " & r.Estatus & "<br>"
        Mensaje += "Importe: " & CDec(r.Total).ToString("n2") & "<br>"
        Archivo = "CXP\" & CInt(r.idEmpresa).ToString & "-" & CInt(r.Solicitud).ToString & ".pdf"
        Dim Firma2 As String = Encriptar(r.fechasol.ToString("yyyyMMddhhmm") & r.MailSolicitante & Empresa & "-" & Solicitud)
        Dim txt As TextBox = GridView1.Rows(e.CommandArgument).FindControl("TextCorreo")

        Select Case e.CommandName
            Case "Autorizar"
                ta.Ok1(Firma, Empresa, Solicitud, Request("User"))
                ta.OK2(Firma, Empresa, Solicitud, Request("User"))
                LbError.Text = "Gastos Autorizados"
                Panel1.Visible = False
                LbError.Visible = True
                Mensaje += "Autorizó: " & r.Autorizante & "<br>"
                Mensaje += "Comentario: " & txt.Text & "<br>"
                Asunto = "Solicitud de Gastos Autorizada : " & Solicitud

                GeneraArchivo(Archivo, Empresa, Firma2, r.Solicitud, r.Estatus)
            Case "Rechazar"
                Firma = "RECHAZADO"
                ta.Ok1(Firma, Empresa, Solicitud, Request("User"))
                ta.OK2(Firma, Empresa, Solicitud, Request("User"))
                LbError.Text = "Gastos Rechazados"
                Panel1.Visible = False
                LbError.Visible = True
                Mensaje += "Rechazó: " & r.Autorizante & "<br>"
                Mensaje += "Comentario: " & txt.Text & "<br>"
                Asunto = "Solicitud de Gastos Rechazada : " & Solicitud
                GeneraArchivo(Archivo, Empresa, Firma2, r.Solicitud, r.Estatus)
            Case "Correo"
                If txt.Text.Length <= 0 Then
                    Exit Sub
                End If
                LbError.Text = "Correo Enviado"
                Panel1.Visible = False
                LbError.Visible = True
                Mensaje += "Comentario: " & txt.Text & "<br>"
                Asunto = "Comentarios de Gastos y Facturas: " & Solicitud
        End Select
        MandaCorreo("Gastos@finagil.com.mx", r.MailSolicitante, Asunto, Mensaje, Archivo)
        MandaCorreoFase("Gastos@finagil.com.mx", "SISTEMAS", Asunto, Mensaje, Archivo)
        Response.Redirect("~\5Afdb804-7cXp.aspx?User=" & Request("User"))
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

End Class