Imports System
Imports System.IO
Imports System.Collections.Generic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.HtmlControls
Imports System.Collections
Imports System.Xml
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Public Class ConsultaEFOS
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Sub limpiar()
        lbNombre.Text = ""
        lbRFC.Text = ""
        lbTipoPersona.Text = ""
        lbError.Visible = False
        lbExiste69.Text = ""
        lbExiste69B.Text = ""
        GridView1.DataSourceID = Nothing
        GridView1.DataSource = Nothing
        GridView1.DataBind()
        GridView2.DataSourceID = Nothing
        GridView2.DataSource = Nothing
        GridView2.DataBind()
        Button1.Visible = False
        'txtConsultar.Text = ""
    End Sub
    Protected Sub btnConsultar_Click(sender As Object, e As EventArgs) Handles btnConsultar.Click

        limpiar()

        If txtConsultar.Text.Length <> 12 And txtConsultar.Text.Length <> 13 Then
            lbError.Visible = True
            Exit Sub
        End If

        Dim ta69 As New DataSet1TableAdapters.CRED_Lista_Art69TableAdapter
        Dim ta69B As New DataSet1TableAdapters.CRED_Lista_Art69BTableAdapter
        Dim resultado69 As DataSet1.CRED_Lista_Art69Row
        Dim resultado69b As DataSet1.CRED_Lista_Art69BRow

        Dim DS69 As New DataSet1
        Dim DS69B As New DataSet1

        ta69.Art69_FillBy(DS69.CRED_Lista_Art69, txtConsultar.Text)
        ta69B.Art69B_FillBy(DS69B.CRED_Lista_Art69B, txtConsultar.Text)

        Dim dt As New DataTable()
        Dim dr As DataRow = Nothing
        dt.Columns.Add(New DataColumn("Estatus", GetType(String)))

        For Each resultado69 In DS69.CRED_Lista_Art69.Rows
            dr = dt.NewRow()
            dr("Estatus") = resultado69.supuesto
            dt.Rows.Add(dr)
        Next

        GridView1.DataSource = dt
        GridView1.DataBind()

        Dim dtb As New DataTable()
        Dim drb As DataRow = Nothing
        dtb.Columns.Add(New DataColumn("Estatus", GetType(String)))

        For Each resultado69b In DS69B.CRED_Lista_Art69B.Rows
            drb = dtb.NewRow()
            drb("Estatus") = resultado69b.status_cont
            dtb.Rows.Add(drb)
        Next

        GridView2.DataSource = dtb
        GridView2.DataBind()

        lbExiste69.Visible = False
        lbExiste69B.Visible = False
        lbNombre.Text = ta69.Obt_Nombre_ScalarQuery(txtConsultar.Text.Trim)
        lbRFC.Text = ta69.Obt_RFC_ScalarQuery(txtConsultar.Text.Trim)
        lbTipoPersona.Text = ta69.Obt_TP_ScalarQuery(txtConsultar.Text.Trim)

        If lbNombre.Text = "" Then
            lbNombre.Text = ta69B.Obt_Nombre_ScalarQuery(txtConsultar.Text.Trim)
            lbRFC.Text = txtConsultar.Text
            If lbRFC.Text.TRIM.Length = 12 Then
                lbTipoPersona.Text = "M"
            Else
                lbTipoPersona.Text = "F"
            End If
        End If

        ta69.Art69_FillBy(DS69.CRED_Lista_Art69, txtConsultar.Text)
        ta69B.Art69B_FillBy(DS69B.CRED_Lista_Art69B, txtConsultar.Text)

        If GridView1.Rows.Count = 0 Then
            lbExiste69.Text = "No existe en la lista"
            lbExiste69.Visible = True
        ElseIf GridView2.Rows.Count = 0 Then
            lbExiste69B.Text = "No existe en la lista"
            lbExiste69B.Visible = True
        End If

        If GridView1.Rows.Count = 0 And GridView2.Rows.Count = 0 Then
            txtNombreIngresar.Visible = True
            lbLeyendaImpresion.Visible = True
            lbExiste69.Text = "No existe en la lista"
            lbExiste69.Visible = True
            lbExiste69B.Text = "No existe en la lista"
            lbExiste69B.Visible = True
            Dim nombreCont As String = txtNombreIngresar.Text 'InputBox("El contribuyente no existe en la lista, ingresa el nombre para poder generar el reporte", "Validación SAT")
            lbNombre.Text = nombreCont.ToUpper
            lbRFC.Text = txtConsultar.Text
            lbExiste69.Visible = False
            lbExiste69B.Visible = False
        End If
        Button1.Visible = True
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim rep As New CrystalDecisions.CrystalReports.Engine.ReportDocument
        Dim taArt69F As New DataSet1TableAdapters.CRED_ListaFechaArf69TableAdapter
        Dim newrptRepSalCli As New ReportDocument()
        newrptRepSalCli.Load(Server.MapPath("~/rptConsultaSAT.rpt"))

        Dim val1 As String = ""
        Dim valB As String = ""
        Dim val2 As String = ""
        Dim val2_pago As String = ""

        For Each row As GridViewRow In GridView1.Rows
            Select Case row.Cells(0).Text
                Case "FIRMES"
                    val1 = "1. DE CONTRIBUYENTE QUE TIENE CRÉDITOS FISCALES FIRMES"
                Case "EXIGIBLES"
                    val1 = "2. CRÉDITOS EXIGIBLES, NO PAGADOS O GARANTIZADOS"
                Case "CANCELADOS"
                    val1 = "3. CRÉDITOS CANCELADOS"
                Case "CONDONADOS"
                    val1 = "4. CRÉDITOS CONDONADOS"
                Case "SENTENCIA"
                    val1 = "5. DE CONTRIBUYENTE QUE TIENE SENTENCIA CONDENATORIA EJECUTORIA POR LA COMISIÓN DE UN DELITO FISCAL"
                Case "NO LOCALIZADO"
                    val1 = "NO LOCALIZADO"
            End Select
            valB += val1 + vbNewLine
        Next

        For Each row As GridViewRow In GridView2.Rows
            val2 += row.Cells(0).Text + vbNewLine
        Next

        If val2.Trim = "Desvirtuado" Or val2 = "" Then
            val2_pago = "PAGO PROCEDENTE A PROVEEDOR"
        Else
            val2_pago = "NO PROCEDE EL PAGO A PROVEEDOR, SOLICITAR ACLARACION"
        End If

        newrptRepSalCli.SetParameterValue("var_nombre", lbNombre.Text)
        newrptRepSalCli.SetParameterValue("var_rfc", lbRFC.Text)
        newrptRepSalCli.SetParameterValue("var_tipo_contribuyente", lbTipoPersona.Text.ToString.Replace("F", "Física").Replace("M", "Moral"))
        newrptRepSalCli.SetParameterValue("var_1", valB)
        newrptRepSalCli.SetParameterValue("var_2", val2)
        newrptRepSalCli.SetParameterValue("var_pago", val2_pago)
        newrptRepSalCli.SetParameterValue("fecha_consulta_SAT", taArt69F.Obt_fecha_ScalarQuery)



        Dim cad As String = "\WEBTASAS\tmp\" & Date.Now.ToString("yyyyMMddmmss") & ".pdf"
        newrptRepSalCli.ExportToDisk(ExportFormatType.PortableDocFormat, Server.MapPath(cad))

        Response.Write("<script>")
        cad = cad.Replace("\", "/")
        cad = cad.Replace("~", "..")
        Response.Write("window.open('" & cad & "','_blank')")
        Response.Write("</script>")
        txtNombreIngresar.Visible = False
        lbLeyendaImpresion.Visible = False
        limpiar()
    End Sub

End Class