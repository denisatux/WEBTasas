Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Public Class DeyelCasosForm
    Inherits System.Web.UI.Page
    Dim taOBS As New ProDSTableAdapters.CXP_ObservacionesSolicitudTableAdapter
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            LbError.Visible = False
        Catch ex As Exception
            Panel1.Visible = False
            LbError.Visible = True
        End Try
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView1.SelectedIndexChanged
        Session("ACTIVIDAD") = GridView1.SelectedDataKey("ACTIVIDAD")
    End Sub
End Class