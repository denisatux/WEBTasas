Partial Public Class BitacoraForm
    Inherits System.Web.UI.Page
    Dim Tipo As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request("ID") <= 0 Then
            Panel1.Visible = False
            LbError.Visible = True
        Else
            If Not IsNothing(Request("Tipo")) Then
                Session.Item("Tipo") = Request("Tipo")
            End If

            Dim ta As New ProDSTableAdapters.BitacoraMCTableAdapter
            Dim Correos As New SeguridadDSTableAdapters.UsuariosFinagilTableAdapter
            Dim t As New ProDS.BitacoraMCDataTable
            ta.Fill(t, Request("ID"))
            Dim R As ProDS.BitacoraMCRow
            If t.Rows.Count > 0 Then
                R = t.Rows(0)
                If Request("Tipo") = "V" Then
                    If R.VoboB = False Then
                        Panel1.Visible = True
                        LbError.Visible = False
                        BotonEnviar1.Text = "Dar Vobo"
                        BotonEnviar1.TextoEnviando = "Dar Vobo"
                    Else
                        Panel1.Visible = False
                        LbError.Visible = True
                        LbError.Text = "Solicitud con Visto bueno"
                    End If
                Else
                    If R.AutorizaB = False Then
                        Panel1.Visible = True
                        LbError.Visible = False
                    Else
                        Panel1.Visible = False
                        LbError.Visible = True
                        LbError.Text = "Solicitud Autorizada"
                    End If
                End If
                Select Case Trim(R.Solicito)
                    Case "vcruz", "cjuarez"
                        If R.AuditoriaExterna = False Then
                            Session.Item("Autoriza") = "vgomez"
                            Session.Item("Vovo") = ""
                        Else
                            If Request("Tipo") = "V" Then
                                Session.Item("Vobo") = "epineda"
                                Session.Item("Autoriza") = ""
                            Else
                                Session.Item("Autoriza") = "vgomez"
                                Session.Item("Vovo") = ""
                            End If
                        End If
                    Case "asagar"
                        Session.Item("Autoriza") = "vgomez"
                        Session.Item("Vovo") = ""
                    Case "gramirez"
                        Session.Item("Autoriza") = "epineda"
                        Session.Item("Vovo") = ""
                    Case "elizabeth.romero", "gisvazquez"
                        Session.Item("Autoriza") = "atorres"
                        Session.Item("Vovo") = ""
                    Case Else
                        If Correos.ScalarDepto(R.Solicito) = "PROMOCION" Then
                            If Request("Tipo") = "V" Then
                                Session.Item("Vobo") = "mleal"
                                Session.Item("Autoriza") = ""
                            Else
                                Session.Item("Autoriza") = "vgomez"
                                Session.Item("Vovo") = ""
                            End If
                        ElseIf Correos.ScalarDepto(R.Solicito) = "JURIDICO" Then
                            Session.Item("Autoriza") = "jjavier"
                            Session.Item("Vovo") = ""
                        Else
                            If Request("Tipo") = "V" Then
                                Session.Item("Vobo") = "lmercado"
                                Session.Item("Autoriza") = ""
                            Else
                                Session.Item("Autoriza") = "vgomez"
                                Session.Item("Vovo") = ""
                            End If
                        End If
                End Select

            Else
                Panel1.Visible = False
                LbError.Visible = True
            End If
        End If



    End Sub

    Protected Sub BotonEnviar1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BotonEnviar1.Click
        Dim ta As New ProDSTableAdapters.BitacoraMCTableAdapter

        If Session.Item("Tipo") = "V" Then
            ta.UpdateVobo(Request("ID"))
            LbError.Text = "Solicitud con Visto bueno"
        ElseIf Session.Item("Tipo") = "AA" Then
            ta.UpdateAAutoriza(Request("ID"))
            LbError.Text = "Solicitud Autorizada"
            EnviaCorreoBitacoraMC(Request("ID"))
        Else
            ta.UpdateAutoriza(Request("ID"))
            LbError.Text = "Solicitud Autorizada"
            EnviaCorreoBitacoraMC(Request("ID"))
        End If
        ObjectDataSource1.DataBind()
        Panel1.Visible = False
        LbError.Visible = True
    End Sub

    Protected Sub Page_ini(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Dim ta As New ProDSTableAdapters.BitacoraMCTableAdapter
        Dim Correos As New SeguridadDSTableAdapters.UsuariosFinagilTableAdapter
        Dim t As New ProDS.BitacoraMCDataTable
        ta.Fill(t, Request("ID"))
        Dim R As ProDS.BitacoraMCRow
        If t.Rows.Count > 0 Then
            R = t.Rows(0)
            Session.Item("Solicita") = R.Solicito
            If Not IsNothing(Request("Tipo")) Then
                Session.Item("Tipo") = Request("Tipo")
            End If
            Select Case Trim(R.Solicito)
                Case "vcruz", "cjuarez"
                    If R.AuditoriaExterna = False Then
                        Session.Item("Autoriza") = "vgomez"
                        Session.Item("Vovo") = ""
                    Else
                        If Request("Tipo") = "V" Then
                            Session.Item("Vobo") = "epineda"
                            Session.Item("Autoriza") = ""
                        Else
                            Session.Item("Autoriza") = "vgomez"
                            Session.Item("Vovo") = ""
                        End If
                    End If
                Case "asagar"
                    Session.Item("Autoriza") = "vgomez"
                    Session.Item("Vovo") = ""
                Case "gramirez"
                    Session.Item("Autoriza") = "epineda"
                    Session.Item("Vovo") = ""
                Case "lhernandez"
                    Session.Item("Autoriza") = "atorres"
                    Session.Item("Vovo") = ""
                Case Else
                    If Correos.ScalarDepto(R.Solicito) = "PROMOCION" Then
                        If Request("Tipo") = "V" Then
                            Session.Item("Vobo") = "mleal"
                            Session.Item("Autoriza") = ""
                        Else
                            Session.Item("Autoriza") = "vgomez"
                            Session.Item("Vovo") = ""
                        End If
                    ElseIf Correos.ScalarDepto(R.Solicito) = "JURIDICO" Then
                        Session.Item("Autoriza") = "jjavier"
                        Session.Item("Vovo") = ""
                    Else
                        If Request("Tipo") = "V" Then
                            Session.Item("Vobo") = "lmercado"
                            Session.Item("Autoriza") = ""
                        Else
                            Session.Item("Autoriza") = "vgomez"
                            Session.Item("Vovo") = ""
                        End If
                    End If
            End Select
        End If

    End Sub


End Class