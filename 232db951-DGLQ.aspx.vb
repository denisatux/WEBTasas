Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Partial Public Class DGSucursalLQForm
    Inherits System.Web.UI.Page
    Dim Tipo As String
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
        Dim Monto As Decimal = CDec(DetailsView1.Rows(4).Cells(1).Text)
        Dim Nombre As String = DetailsView1.Rows(2).Cells(1).Text.Trim
        Dim ta As New ProDSTableAdapters.SolLiqTableAdapter
        ta.UpdateEstatus("APROBADO", "gbello", Request("ID"))
        Globales.AltaLineaCreditoLIQUIDEZ(Cliente, Monto, "Autorizado por DG")
        GeneraCorreoAUT(Monto, Cliente, Nombre)
        Response.Redirect("~\232db951-DGLQ.aspx?User=" & Request("User") & "&ID=0")
    End Sub

    Sub GeneraCorreoAUT(Monto As Decimal, Cliente As String, nombre As String)
        Dim TaQUERY As New CreditoDSTableAdapters.LlavesTableAdapter
        Dim Asunto As String = ""
        Dim Fecha As Date = DetailsView1.Rows(8).Cells(1).Text.Trim
        Dim Antiguedad As Integer = DateDiff(DateInterval.Year, Fecha, Date.Now.Date)
        GeneraDocAutorizacion(Request("ID"), Antiguedad)
        Asunto = "Solicitud de Liquidez Inmediata Autorizada: " & nombre
        Dim Mensaje As String = ""

        Mensaje += "Cliente: " & nombre & "<br>"
        Mensaje += "Monto Financiado: " & Monto.ToString("n2") & "<br>"

        EnviacORREO("ecacerest@finagil.com.mx", Mensaje, Asunto, "gbello@Fiangil.com.mx")
        EnviacORREO(TaQUERY.SacaCorreoPromo(Cliente), Mensaje, Asunto, "gbello@Fiangil.com.mx")

    End Sub

    Function GeneraDocAutorizacion(ID_Sol2 As Integer, Antiguedad As String) As String
        Dim DS As New ProDS
        Dim Archivo As String = "\WEBTASAS\tmp\" & Date.Now.ToString("yyyyMMddmmss") & ".pdf"
        Dim reporte As New ReportDocument()
        reporte.Load(Server.MapPath("~/rptAltaLiquidezAutorizacion.rpt"))
        Dim ta As New ProDSTableAdapters.AutorizacionRPTTableAdapter
        ta.Fill(DS.AutorizacionRPT, ID_Sol2)

        reporte.SetDataSource(DS)
        reporte.SetParameterValue("var_antiguedad", Antiguedad)
        reporte.SetParameterValue("Autorizo", "C.P. GABRIEL BELLO HERNANDEZ")
        reporte.SetParameterValue("AreaAutorizo", "DIRECCION GENERAL")
        reporte.SetParameterValue("Firma", Encriptar("GBELLO" & Date.Now.ToString))
        Try
            reporte.ExportToDisk(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Archivo)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        Return Archivo
    End Function

End Class