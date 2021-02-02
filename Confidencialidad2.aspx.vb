Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Public Class Confidencialidad2
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim rptCARTA As New ReportDocument

        rptCARTA.Load(Server.MapPath("~/Confidencialidad_rpt.rpt"))
        rptCARTA.Refresh()

        Dim nombre As String = UCase(Request.QueryString("nombre"))
        Dim empresa As String = UCase(Request.QueryString("empresa"))
        Dim equipo As String = UCase(Request.QueryString("equipo"))
        rptCARTA.SetParameterValue("nombre", nombre)
        rptCARTA.SetParameterValue("empresa", empresa)
        rptCARTA.SetParameterValue("equipo", equipo)
        Dim rutaPDF As String = "~\TmpFinagil\" & nombre & ".pdf"
        'Dim rutaPDF As String = "\\server-NAS\TMPFINAGIL\PLD\" & nombre & ".pdf"

        rptCARTA.ExportToDisk(ExportFormatType.PortableDocFormat, Server.MapPath(rutaPDF))
        Response.Write("<script>")
        rutaPDF = rutaPDF.Replace("\", "/")
        rutaPDF = rutaPDF.Replace("~", "..")
        Response.Write("window.open('verPdf.aspx','popup','_blank','width=200,height=200')")
        Response.Write("</script>")
        rptCARTA.Dispose()
        Response.Redirect("~/Confidencialidad.aspx")

    End Sub


End Class