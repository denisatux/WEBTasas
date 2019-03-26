Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.IO
Partial Public Class DGSucursalLQForm
    Inherits System.Web.UI.Page
    Dim Tipo As String
    Dim TaQUERY As New CreditoDSTableAdapters.LlavesTableAdapter
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsNothing(Request("User")) Then
            Panel1.Visible = False
            LbError.Visible = True
        Else
            Dim ta As New ProDSTableAdapters.SolLiqTableAdapter
            Dim Correos As New SeguridadDSTableAdapters.UsuariosFinagilTableAdapter
            Dim t As New ProDS.SolLiqDataTable
            ta.Fill(t, Request("User"))
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
        Dim Cliente As String = DetailsView1.Rows(1).Cells(1).Text
        Dim Monto As Decimal = CDec(DetailsView1.Rows(3).Cells(1).Text)
        Dim Nombre As String = DetailsView1.Rows(2).Cells(1).Text.Trim
        Dim Analista As String = DetailsView1.Rows(11).Cells(1).Text.Trim
        Dim ta As New ProDSTableAdapters.SolLiqTableAdapter
        ta.UpdateEstatus("APROBADO", Request("User"), True, Request("ID"))
        Globales.AltaLineaCreditoLIQUIDEZ(Cliente, Monto, "Autorizado por " & Request("User"), Request("User"))
        GeneraCorreoAUT(Monto, Cliente, Nombre, Analista)
        Response.Redirect("~\232db951-DGLQ.aspx?User=" & Request("User") & "&ID=0")
    End Sub

    Sub GeneraCorreoAUT(Monto As Decimal, Cliente As String, nombre As String, Analista As String)
        Dim ta As New SeguridadDSTableAdapters.UsuariosFinagilTableAdapter
        Dim Asunto As String = ""
        Dim Fecha As Date = DetailsView1.Rows(14).Cells(1).Text.Trim
        Dim Antiguedad As Integer = DateDiff(DateInterval.Year, Fecha, Date.Now.Date)
        Dim File As String = GeneraDocAutorizacion(Request("ID"), Antiguedad, Analista, Cliente)
        Asunto = "Solicitud de Liquidez Inmediata Autorizada: " & nombre
        Dim Mensaje As String = ""

        Mensaje += "Cliente: " & nombre & "<br>"
        Mensaje += "Monto Financiado: " & Monto.ToString("n2") & "<br>"

        MandaCorreo(Request("User") & "@Fiangil.com.mx", "ecacerest@finagil.com.mx", Asunto, Mensaje, File)
        MandaCorreo(Request("User") & "@Fiangil.com.mx", ta.ScalarCorreo(Analista), Asunto, Mensaje, File)
        MandaCorreo(Request("User") & "@Fiangil.com.mx", TaQUERY.SacaCorreoPromo(Cliente), Asunto, Mensaje, File)

    End Sub

    Function GeneraDocAutorizacion(ID_Sol2 As Integer, Antiguedad As String, Analista As String, Cliente As String) As String
        Dim ta1 As New SeguridadDSTableAdapters.UsuariosFinagilTableAdapter
        Dim DS As New ProDS
        Dim Archivo As String = "D:\TmpFinagil\" & "Autoriza" & ID_Sol2 & ".Pdf"
        Dim Archivo2 As String = "Autoriza" & ID_Sol2 & ".Pdf"
        Dim reporte As New ReportDocument()
        reporte.Load(Server.MapPath("~/rptAltaLiquidezAutorizacion.rpt"))
        Dim ta As New ProDSTableAdapters.AutorizacionRPTTableAdapter
        ta.Fill(DS.AutorizacionRPT, ID_Sol2)

        reporte.SetDataSource(DS)
        reporte.SetParameterValue("var_antiguedad", Antiguedad)
        If Request("User") = "gbello" Then
            reporte.SetParameterValue("Autorizo", "C.P. GABRIEL BELLO HERNANDEZ")
            reporte.SetParameterValue("AreaAutorizo", "DIRECCION GENERAL")
        Else
            reporte.SetParameterValue("Autorizo", "VERONICA GOMEZ GARCIA")
            reporte.SetParameterValue("AreaAutorizo", "SUB DIRECCION DE CREDITO")
        End If
        reporte.SetParameterValue("Analista", UCase(Trim(ta1.ScalarNombre(Analista))))
        reporte.SetParameterValue("FirmaAnalista", Encriptar(Analista & Date.Now.ToString))
        reporte.SetParameterValue("Firma", Encriptar(Request("User") & Date.Now.ToString))
        Dim Aux As String = TaQUERY.SacaCorreoPromo(Cliente)
        Dim Promo() As String = Aux.Split("@")
        reporte.SetParameterValue("FirmaPromo", Encriptar(Promo(0) & Date.Now.ToString))

        Try
            File.Delete(Archivo)
            reporte.ExportToDisk(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Archivo)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        Return Archivo2
    End Function

    Protected Sub BotonEnviar2_Click(sender As Object, e As EventArgs) Handles BotonEnviar2.Click
        Dim Cliente As String = DetailsView1.Rows(1).Cells(1).Text
        Dim Monto As Decimal = CDec(DetailsView1.Rows(3).Cells(1).Text)
        Dim Nombre As String = DetailsView1.Rows(2).Cells(1).Text.Trim
        Dim Analista As String = DetailsView1.Rows(11).Cells(1).Text.Trim
        Dim ta As New ProDSTableAdapters.SolLiqTableAdapter
        ta.UpdateEstatus("RECHAZADO", Request("User"), True, Request("ID"))
        GeneraCorreoRECHAZO(Monto, Cliente, Nombre, Analista)
        Response.Redirect("~\232db951-DGLQ.aspx?User=" & Request("User") & "&ID=0")
    End Sub

    Sub GeneraCorreoRECHAZO(Monto As Decimal, Cliente As String, nombre As String, Analista As String)
        Dim ta As New SeguridadDSTableAdapters.UsuariosFinagilTableAdapter
        Dim Asunto As String = ""
        Asunto = "Solicitud de Liquidez Inmediata Rechazada: " & nombre
        Dim Mensaje As String = ""

        Mensaje += "Cliente: " & nombre & "<br>"
        Mensaje += "Monto Financiado: " & Monto.ToString("n2") & "<br>"
        Mensaje += "Comentarios DG: " & TextComentario.Text & "<br>"

        MandaCorreo(Request("User") & "@Fiangil.com.mx", "ecacerest@finagil.com.mx", Asunto, Mensaje)
        MandaCorreo(Request("User") & "@Fiangil.com.mx", ta.ScalarCorreo(Analista), Asunto, Mensaje)
        MandaCorreo(Request("User") & "@Fiangil.com.mx", TaQUERY.SacaCorreoPromo(Cliente), Asunto, Mensaje)

    End Sub

    Sub GeneraCorreoREGRESO(Monto As Decimal, Cliente As String, nombre As String, Analista As String)
        Dim ta As New SeguridadDSTableAdapters.UsuariosFinagilTableAdapter
        Dim Asunto As String = ""
        Asunto = "Solicitud de Liquidez Inmediata de regreso por DG: " & nombre
        Dim Mensaje As String = ""

        Mensaje += "Cliente: " & nombre & "<br>"
        Mensaje += "Monto Financiado: " & Monto.ToString("n2") & "<br>"
        Mensaje += "Comentarios DG: " & TextComentario.Text & "<br>"

        MandaCorreo(Request("User") & "@Fiangil.com.mx", "ecacerest@finagil.com.mx", Asunto, Mensaje)
        MandaCorreo(Request("User") & "@Fiangil.com.mx", ta.ScalarCorreo(Analista), Asunto, Mensaje)
        MandaCorreo(Request("User") & "@Fiangil.com.mx", TaQUERY.SacaCorreoPromo(Cliente), Asunto, Mensaje)

    End Sub

    Protected Sub BotonEnviar3_Click(sender As Object, e As EventArgs) Handles BotonEnviar3.Click
        Dim Cliente As String = DetailsView1.Rows(1).Cells(1).Text
        Dim Monto As Decimal = CDec(DetailsView1.Rows(3).Cells(1).Text)
        Dim Nombre As String = DetailsView1.Rows(2).Cells(1).Text.Trim
        Dim Analista As String = DetailsView1.Rows(11).Cells(1).Text.Trim
        Dim ta As New ProDSTableAdapters.SolLiqTableAdapter
        ta.UpdateEstatus("PENDIENTE", Request("User"), False, Request("ID"))
        GeneraCorreoREGRESO(Monto, Cliente, Nombre, Analista)
        Response.Redirect("~\232db951-DGLQ.aspx?User=" & Request("User") & "&ID=0")
    End Sub
End Class
