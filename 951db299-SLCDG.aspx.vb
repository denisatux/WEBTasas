Partial Public Class DGLineaForm
    Inherits System.Web.UI.Page
    Dim Tipo As String
    Const DGcorreo As String = "gbello@finagil.com.mx"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsNothing(Request("ID")) Then
            Panel1.Visible = False
            LbError.Visible = True
        Else
            Dim ta As New CreditoDSTableAdapters.CRED_SolicitudLineaDGTableAdapter
            Dim Correos As New SeguridadDSTableAdapters.UsuariosFinagilTableAdapter
            Dim t As New CreditoDS.CRED_SolicitudLineaDGDataTable
            ta.Fill(t, Request("ID"))
            If t.Rows.Count > 0 Then
                If Request("ID") = 0 Then
                    Panel1.Visible = True
                    LbError.Visible = False
                    BotonEnviar1.Visible = False
                Else
                    Panel1.Visible = True
                    LbError.Visible = False
                    BotonEnviar1.Visible = True
                End If
            Else
                Panel1.Visible = False
                LbError.Visible = True
            End If
        End If
    End Sub

    Protected Sub BotonEnviar1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BotonEnviar1.Click
        Dim BITACORA As New ProDSTableAdapters.GEN_BitacoraFinagilTableAdapter
        Dim taSol As New CreditoDSTableAdapters.CRED_SolicitudLineaDGTableAdapter
        Dim taLine As New CreditoDSTableAdapters.Credit1TableAdapter
        Dim DS As New CreditoDS
        Dim rsol As CreditoDS.CRED_SolicitudLineaDGRow
        Dim rline As CreditoDS.Credit1Row

        taSol.Fill(DS.CRED_SolicitudLineaDG, Request("ID"))
        rsol = DS.CRED_SolicitudLineaDG.Rows(0)
        taLine.Fill(DS.Credit1, rsol.Anexo)
        rline = DS.Credit1.Rows(0)

        rline.Dicta = "A"
        rline.Statu = "5"
        rline.Linau = rsol.Importe
        rline.Fevig = Date.Now.AddMonths(1).ToString("yyyyMMdd")
        rsol.Autoriza1 = "Gbello"
        rsol.Autorizacion1 = True

        DS.CRED_SolicitudLineaDG.GetChanges()
        taSol.Update(DS.CRED_SolicitudLineaDG)

        DS.Credit1.GetChanges()
        taLine.Update(DS.Credit1)

        Dim HostName As String = System.Net.Dns.GetHostEntry(Request.UserHostAddress).HostName
        BITACORA.Insert("Gbello", "WebTasas", Date.Now, "LineaCredito", HostName, rsol.Importe.ToString)
        GeneraCorreo()
        Response.Redirect("~\951db299-SLCDG.aspx")
    End Sub

    Sub GeneraCorreo()
        Dim Asunto As String = "Solicitud de Linea de Credito Autorizada po Dirección General: " & DetailsView1.Rows(1).Cells(1).Text.Trim
        Dim Mensaje As String = ""
        Mensaje += "Cliente: " & DetailsView1.Rows(1).Cells(1).Text.Trim & "<br>"
        Mensaje += "Monto de la Linea: " & CDec(DetailsView1.Rows(5).Cells(1).Text).ToString("N2") & "<br>"
        Mensaje += "Observaciones: " & DetailsView1.Rows(4).Cells(1).Text.Trim & "<br>"

        MandaCorreoFase(DGcorreo, "CREDITO", Asunto, Mensaje)
        MandaCorreoFase(DGcorreo, "OPERACIONES", Asunto, Mensaje)
        MandaCorreoFase(DGcorreo, "DG", Asunto, Mensaje)
        MandaCorreoFase(DGcorreo, "SISTEMAS", Asunto, Mensaje)
    End Sub

End Class