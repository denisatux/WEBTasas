Partial Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request("ID") <= 0 Then
            Panel1.Visible = False
            LbError.Visible = True
        Else
            Dim ta As New ProDSTableAdapters.VWBloqueoTableAdapter
            Dim t As New ProDS.VWBloqueoDataTable
            ta.Fill(t, Request("ID"))
            Dim R As ProDS.VWBloqueoRow
            If t.Rows.Count > 0 Then
                R = t.Rows(0)
                If R.AutorizadoRI = False Then
                    Panel1.Visible = True
                    LbError.Visible = False
                Else
                    Panel1.Visible = False
                    LbError.Visible = True
                End If
            Else
                Panel1.Visible = False
                LbError.Visible = True
            End If
            
        End If
    End Sub

    Protected Sub BotonEnviar1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BotonEnviar1.Click
        Dim ta As New ProDSTableAdapters.GEN_Bloqueo_TasasTableAdapter
        Dim Diff As Decimal = DetailsView1.DataKey(1)
        Dim Firma As String = Encriptar(Date.Now.ToString("yyyyMMddhhmm") & "-Cmonroy")
        If Diff <= 0.5 And Diff >= -0.5 Then 'facultades de Riesgos
            ta.Autoriza(Txtcom.Text.ToUpper, TxtIndi.Text.ToUpper, True, True, "RI", False, Firma, DetailsView1.DataKey(0))
        Else
            ta.Autoriza(Txtcom.Text.ToUpper, TxtIndi.Text.ToUpper, True, False, "DG", False, Firma, DetailsView1.DataKey(0))
        End If
        LbError.Text = "Tasa Autorizada"
        Panel1.Visible = False
        LbError.Visible = True
    End Sub

    Protected Sub BotonEnviar2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BotonEnviar2.Click
        Dim ta As New ProDSTableAdapters.GEN_Bloqueo_TasasTableAdapter
        Dim Diff As Decimal = DetailsView1.DataKey(1)
        Dim Firma As String = Encriptar(Date.Now.ToString("yyyyMMddhhmm") & "-Cmonroy")
        ta.Autoriza(Txtcom.Text.ToUpper, TxtIndi.Text.ToUpper, True, False, "DG", False, Firma, DetailsView1.DataKey(0))
        LbError.Text = "Enviada a Dirección General"
        Panel1.Visible = False
        LbError.Visible = True
    End Sub

    Protected Sub BotonEnviar3_Click(sender As Object, e As EventArgs) Handles BotonEnviar3.Click
        Dim ta As New ProDSTableAdapters.GEN_Bloqueo_TasasTableAdapter
        Dim Anexo As String = DetailsView1.DataKey(2)
        ta.RechazarSolicitud(Txtcom.Text.ToUpper, TxtIndi.Text.ToUpper, True, True, "RECHAZADO", False, DetailsView1.DataKey(0))
        LbError.Text = "Solicitud Rechazada"
        Panel1.Visible = False
        LbError.Visible = True
    End Sub
End Class