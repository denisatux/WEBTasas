Partial Public Class SUBForm
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request("ID") <= 0 Then
            Panel1.Visible = False
            LbError.Visible = True
        Else
            Dim ta As New ProDSTableAdapters.VWBloqueoTableAdapter
            Dim t As New ProDS.VWBloqueoDataTable
            ta.FillByDG(t, Request("ID"))
            Dim R As ProDS.VWBloqueoRow
            If t.Rows.Count > 0 Then
                R = t.Rows(0)
                If R.FirmaSubPromo.Trim = "" Then
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
        Dim Firma As String = Encriptar(Date.Now.ToString("yyyyMMddhhmm") & "-Mleal")
        ta.AutorizaSUB(Firma, DetailsView1.DataKey(0))
        LbError.Text = "Tasa Autorizada"
        Panel1.Visible = False
        LbError.Visible = True
    End Sub


End Class