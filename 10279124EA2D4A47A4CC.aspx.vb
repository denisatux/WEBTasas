Partial Public Class CRED_SEGUI
    Inherits System.Web.UI.Page
    Dim Tipo As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim ta As New ProDSTableAdapters.CRED_SeguimientosTableAdapter
        Dim t As New ProDS.CRED_SeguimientosDataTable
        ta.Fill(t, Session("Depto"), Session("Aux"))
        If t.Rows.Count > 0 Then
            If Request("ID") = 0 Then
                Panel1.Visible = True
                LbError.Visible = False
            Else
                Panel1.Visible = True
                LbError.Visible = False
            End If
        Else
            Panel1.Visible = False
            LbError.Visible = True
        End If
    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim cell As TableCell = e.Row.Cells(8)
            Dim Dias As Integer = Integer.Parse(cell.Text)
            Select Case Dias
                Case < -3 ' verde
                    cell.BackColor = Drawing.Color.Green
                    cell.ForeColor = Drawing.Color.White
                Case < 0 ' amarillo
                    cell.BackColor = Drawing.Color.Yellow
                    cell.ForeColor = Drawing.Color.White
                Case >= 0 'rojo
                    cell.BackColor = Drawing.Color.Red
                    cell.ForeColor = Drawing.Color.Black
            End Select
        End If
    End Sub

    Private Sub CRED_SEGUI_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        Select Case Request("Depto").ToUpper
            Case "CRED"
                Session("Depto") = "CREDITO"
                Session("Aux") = "ZZZZ"
            Case "JUR"
                Session("Depto") = "JURIDICO"
                Session("Aux") = "ZZZZ"
            Case "MC"
                Session("Depto") = "MESA DE CONTROL"
                Session("Aux") = "ZZZZ"
            Case Else
                Session("Depto") = "TODO"
                Session("Aux") = "a"
        End Select
        Label1.Text += " " & Session("Depto")
    End Sub
End Class