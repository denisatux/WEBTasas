Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Public Class CPXForm8
    Inherits System.Web.UI.Page
    Dim taOBS As New ProDSTableAdapters.CXP_ObservacionesSolicitudPagosTableAdapter
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not IsNothing(Request("User")) Then
                Session.Item("User") = Request("User")
                Response.Redirect("~\5Afdb804-8cXp.aspx", True)
            End If
            If IsNothing(Session("User")) Then
                Panel1.Visible = False
                LbError.Visible = True
            Else
                Dim ta As New ProDSTableAdapters.Vw_CXP_ComprobacionGastosResumTableAdapter
                Dim t As New ProDS.Vw_CXP_ComprobacionGastosResumDataTable
                ta.Fill(t, Session("User"))
                Dim R As ProDS.Vw_CXP_ComprobacionGastosResumRow
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

    Sub GeneraArchivo(Archivo As String, Empresa As Decimal, FirmaSol As String, Solicitud As Decimal, Serie As String)
        Dim ta As New ProDSTableAdapters.Vw_CXP_ComprobacionGastosTableAdapter
        Dim rptComprobacion As New rptComprobacionGts
        Dim ds1 As New ProDS
        Dim ds2 As New ProDS
        Dim ds3 As New ProDS

        ta.Fill(ds1.Vw_CXP_ComprobacionGastos, CDec(Empresa), Solicitud)
        ta.FillND(ds2.Vw_CXP_ComprobacionGastos, CDec(Empresa), Solicitud)
        ta.FillDND(ds3.Vw_CXP_ComprobacionGastos, CDec(Empresa), Solicitud)

        rptComprobacion.SetDataSource(ds1)
        rptComprobacion.Subreports(0).SetDataSource(ds2)
        rptComprobacion.Subreports(1).SetDataSource(ds3)

        Select Case Empresa
            Case 23
                rptComprobacion.SetParameterValue("var_pathImagen", Server.MapPath("~/IMG/LOGO FINAGIL.JPG"))
            Case 24
                rptComprobacion.SetParameterValue("var_pathImagen", Server.MapPath("~/IMG/logoArfin.JPG"))
        End Select

        rptComprobacion.SetParameterValue("var_genero", FirmaSol)
        rptComprobacion.SetParameterValue("var_totalConFactura", FormatCurrency(ta.ImporteSiFacturas(Empresa, Solicitud)))
        rptComprobacion.SetParameterValue("var_totalSinFactura", FormatCurrency(ta.ImporteNoFacturas(Empresa, Solicitud)))
        rptComprobacion.SetParameterValue("var_total", FormatCurrency(ta.Total(Empresa, Solicitud)))

        rptComprobacion.ExportToDisk(ExportFormatType.PortableDocFormat, My.Settings.RUTA_TMP & Archivo)
        rptComprobacion.Dispose()
    End Sub

    Protected Sub BotonAutorizar_Click(sender As Object, e As EventArgs) Handles BotonAutorizar.Click
        Dim ta As New ProDSTableAdapters.Vw_CXP_ComprobacionGastosTableAdapter
        Dim t As New ProDS.Vw_CXP_ComprobacionGastosDataTable
        Dim r As ProDS.Vw_CXP_ComprobacionGastosRow
        Dim Firma As String = Encriptar(Date.Now.ToString("yyyyMMddhhmm") & Session("User") & Session("ID1") & "-" & Session("ID2"))
        Dim Mensaje As String = ""
        Dim Asunto As String = ""
        Dim Archivo As String
        Dim Antorizante As String = ta.SacaNombre(Session("User"))
        ta.Fill(t, Session("ID1"), Session("ID2"))
        r = t.Rows(0)
        Mensaje = "Solicitud: " & r.folioComprobacion & "<br>"
        Mensaje += "Emrpesa: " & r.empresa & "<br>"
        Mensaje += "Importe: " & CDec(r.totalPagado).ToString("n2") & "<br>"
        Archivo = "GTS\" & CInt(r.idEmpresa).ToString & "-" & CInt(r.folioComprobacion.ToString) & ".pdf"
        Dim Firma2 As String = Encriptar(r.fechaSolicitud.ToString("yyyyMMddhhmm") & r.MailSolicitante & Session("ID1") & "-" & Session("ID2"))

        ta.Ok1(Firma, Session("ID1"), Session("ID2"), Session("User"))
        ta.Ok2(Firma, Session("ID1"), Session("ID2"), Session("User"))
        LbError.Text = "Gastos Autorizados"
        Panel1.Visible = False
        LbError.Visible = True
        Mensaje += "Autorizó: " & Antorizante.ToUpper & "<br>"
        Mensaje += "Comentario: " & TextMail.Text & "<br>"
        Asunto = "Solicitud de Gastos Autorizada (" & r.empresa & "): " & Session("ID2")

        If TextMail.Text.Length > 0 Then
            taOBS.Borrar(r.idEmpresa, r.folioComprobacion, Session("User"))
            taOBS.Insert(r.idEmpresa, r.folioComprobacion, Session("User"), TextMail.Text)
        End If
        GeneraArchivo(Archivo, Session("ID1"), Firma2, r.folioComprobacion, r.serie)

        MandaCorreo("Gastos@finagil.com.mx", r.MailSolicitante, Asunto, Mensaje, Archivo)
        MandaCorreoFase("Gastos@finagil.com.mx", "SISTEMAS", Asunto, Mensaje, Archivo)
        Session("ID1") = 0
        Session("ID2") = 0
        Session("ID4") = Nothing
        Response.Redirect("~\5Afdb804-8cXp.aspx", True)
    End Sub

    Protected Sub BotonRechazar_Click(sender As Object, e As EventArgs) Handles BotonRechazar.Click
        Dim ta As New ProDSTableAdapters.Vw_CXP_ComprobacionGastosTableAdapter
        Dim t As New ProDS.Vw_CXP_ComprobacionGastosDataTable
        Dim r As ProDS.Vw_CXP_ComprobacionGastosRow
        Dim Firma As String = Encriptar(Date.Now.ToString("yyyyMMddhhmm") & Session("User") & Session("ID1") & "-" & Session("ID2"))
        Dim Mensaje As String = ""
        Dim Asunto As String = ""
        Dim Archivo As String
        Dim Antorizante As String = ta.SacaNombre(Session("User"))
        ta.Fill(t, Session("ID1"), Session("ID2"))
        r = t.Rows(0)
        Mensaje = "Solicitud: " & r.folioComprobacion & "<br>"
        Mensaje += "Emrpesa: " & r.empresa & "<br>"
        Mensaje += "Importe: " & CDec(r.totalPagado).ToString("n2") & "<br>"
        Archivo = "GTS\" & CInt(r.idEmpresa).ToString & "-" & CInt(r.folioComprobacion).ToString & ".pdf"
        Dim Firma2 As String = Encriptar(r.fechaSolicitud.ToString("yyyyMMddhhmm") & r.MailSolicitante & Session("ID1") & "-" & Session("ID2"))

        Firma = "RECHAZADO"
        ta.Ok1(Firma, Session("ID1"), Session("ID2"), Session("User"))
        ta.Ok2(Firma, Session("ID1"), Session("ID2"), Session("User"))
        LbError.Text = "Gastos Rechazados"
        Panel1.Visible = False
        LbError.Visible = True
        Mensaje += "Rechazó: " & Antorizante.ToUpper & "<br>"
        Mensaje += "Comentario: " & TextMail.Text & "<br>"
        Asunto = "Solicitud de Pago Rechazada (" & r.empresa & "): " & Session("ID2")
        If TextMail.Text.Length <= 0 Then
            TextMail.Text = "RECHAZADO"
        Else
            TextMail.Text = "RECHAZADO" & TextMail.Text
        End If
        taOBS.Borrar(r.idEmpresa, r.folioComprobacion, Session("User"))
        taOBS.Insert(r.idEmpresa, r.folioComprobacion, Session("User"), TextMail.Text)
        GeneraArchivo(Archivo, Session("ID1"), Firma2, r.folioComprobacion, r.serie)

        MandaCorreo("Gastos@finagil.com.mx", r.MailSolicitante, Asunto, Mensaje, Archivo)
        MandaCorreoFase("Gastos@finagil.com.mx", "SISTEMAS", Asunto, Mensaje, Archivo)
        Session("ID1") = 0
        Session("ID2") = 0
        Session("ID4") = Nothing
        Response.Redirect("~\5Afdb804-8cXp.aspx", True)
    End Sub

    Protected Sub BotonCorreo_Click(sender As Object, e As EventArgs) Handles BotonCorreo.Click
        Dim ta As New ProDSTableAdapters.Vw_CXP_ComprobacionGastosTableAdapter
        Dim t As New ProDS.Vw_CXP_ComprobacionGastosDataTable
        Dim r As ProDS.Vw_CXP_ComprobacionGastosRow
        Dim Firma As String = Encriptar(Date.Now.ToString("yyyyMMddhhmm") & Session("User") & Session("ID1") & "-" & Session("ID2"))
        Dim Mensaje As String = ""
        Dim Asunto As String = ""
        Dim Archivo As String
        ta.Fill(t, Session("ID1"), Session("ID2"))
        r = t.Rows(0)
        Mensaje = "Solicitud: " & r.folio & "<br>"
        Mensaje += "Emrpesa: " & r.empresa & "<br>"
        Mensaje += "Importe: " & CDec(r.totalPagado).ToString("n2") & "<br>"
        Archivo = "GTS\" & CInt(r.idEmpresa).ToString & "-" & CInt(r.folioComprobacion).ToString & ".pdf"
        Dim Firma2 As String = Encriptar(r.fechaSolicitud.ToString("yyyyMMddhhmm") & r.MailSolicitante & Session("ID1") & "-" & Session("ID2"))

        If TextMail.Text.Length <= 0 Then
            Exit Sub
        End If
        LbError.Text = "Correo Enviado"
        Panel1.Visible = False
        LbError.Visible = True
        Mensaje += "Comentario: " & TextMail.Text & "<br>"
        Asunto = "Comentarios de Gastos y Facturas (" & r.empresa & "): " & Session("ID2")
        TextMail.Text = ""

        MandaCorreo("Gastos@finagil.com.mx", r.MailSolicitante, Asunto, Mensaje, Archivo)
        MandaCorreoFase("Gastos@finagil.com.mx", "SISTEMAS", Asunto, Mensaje, Archivo)
        Session("ID1") = 0
        Session("ID2") = 0
        Session("ID4") = Nothing
        Response.Redirect("~\5Afdb804-8cXp.aspx", True)
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView1.SelectedIndexChanged
        Session("ID1") = GridView1.SelectedDataKey("idEmpresa")
        Session("ID2") = GridView1.SelectedDataKey("FolioComprobante")
        Session("ID4") = GridView1.SelectedIndex
        Response.Redirect("~\5Afdb804-8cXp.aspx", True)
    End Sub
End Class