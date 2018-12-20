Imports System.Security.Cryptography
Imports System.Net.Mail
Module Globales

    Public Function Encriptar(ByVal Input As String) As String

        Dim IV() As Byte = ASCIIEncoding.ASCII.GetBytes("Finagil1") 'La clave debe ser de 8 caracteres
        Dim EncryptionKey() As Byte = Convert.FromBase64String("rpaSPvIvVLlrcmtzPU9/c67Gkj7yL1S5") 'No se puede alterar la cantidad de caracteres pero si la clave
        Dim buffer() As Byte = Encoding.UTF8.GetBytes(Input)
        Dim des As TripleDESCryptoServiceProvider = New TripleDESCryptoServiceProvider
        des.Key = EncryptionKey
        des.IV = IV
        Return StrReverse(Convert.ToBase64String(des.CreateEncryptor().TransformFinalBlock(buffer, 0, buffer.Length())))

    End Function

    Public Sub EnviaCorreoBitacoraMC(id As Integer)
        '************Solucitud de Documentos MC********************
        Dim solicitudesMC As New ProDSTableAdapters.BitacoraMCTableAdapter
        Dim tsol As New ProDS.BitacoraMCDataTable
        Dim Vobo As String = ""
        Dim Autoriza As String = ""
        Dim Mensaje As String = ""

        solicitudesMC.Fill(tsol, id)
        For Each r As ProDS.BitacoraMCRow In tsol.Rows
            Mensaje = "Contrato: " & r.AnexoCon & "<br>"
            Mensaje += "Cliente: " & r.Descr.Trim & "<br>"
            Mensaje += "Producto: " & r.TipoCredito & "<br>"
            Mensaje += "Solicita: " & r.Solicito & "<br>"
            Mensaje += "Vobo: " & r.vobo & "<br>"
            Mensaje += "Autoriza: " & r.Autoriza & "<br>"
            Mensaje += "Documentos: <br>"
            If r.Contrato = True Then Mensaje += vbTab & "Contrato<br>"
            If r.Pagare = True Then Mensaje += "&nbsp&nbsp&nbsp&nbsp Pagare<br>"
            If r.Garantias = True Then Mensaje += "&nbsp&nbsp&nbsp&nbsp Garantias<br>"
            If r.Facturas = True Then Mensaje += "&nbsp&nbsp&nbsp&nbsp Facturas<br>"
            If r.Convenio = True Then Mensaje += "&nbsp&nbsp&nbsp&nbsp Convenio<br>"
            If r.Escritura = True Then Mensaje += "&nbsp&nbsp&nbsp&nbsp Escritura<br>"
            Mensaje += "Justificación: " & r.Justificacion & "<br>"

            If r.PldB = True Then
                Dim Fase As New ProDSTableAdapters.CorreosFasesTableAdapter
                Dim FaseT As New ProDS.CorreosFasesDataTable
                Dim f As ProDS.CorreosFasesRow

                Fase.Fill(FaseT, "MESA_CONTROL")
                For Each f In FaseT.Rows
                    EnviacORREO(f.Correo, Mensaje, "Solicitud de Documentos Autorizada(" & r.Descr.Trim & ")", "BitacoraMC@lamoderna.com.mx")
                Next
                Fase.Fill(FaseT, "PLD")
                For Each f In FaseT.Rows
                    EnviacORREO(f.Correo, Mensaje, "Solicitud de Documentos Autorizada(" & r.Descr.Trim & ")", "BitacoraMC@lamoderna.com.mx")
                Next
                Fase.Fill(FaseT, "GV_" & r.Nombre_Sucursal.Trim)
                For Each f In FaseT.Rows
                    EnviacORREO(f.Correo, Mensaje, "Solicitud de Documentos Autorizada(" & r.Descr.Trim & ")", "BitacoraMC@lamoderna.com.mx")
                Next
                EnviacORREO(r.Solicito.Trim & "@finagil.com.mx", Mensaje, "Solicitud de Documentos Autorizada(" & r.Descr.Trim & ")", "BitacoraMC@lamoderna.com.mx")
            End If
        Next

    End Sub

    Public Sub EnviacORREO(ByVal Para As String, ByVal Mensaje As String, ByVal Asunto As String, de As String)

        Dim Mensage As New MailMessage(Trim(de), Trim(Para), Trim(Asunto), Mensaje)
        Dim Cliente As New SmtpClient("smtp01.cmoderna.com", 26)
        Try
            Mensage.IsBodyHtml = True
            Cliente.Send(Mensage)
        Catch ex As Exception

        End Try

    End Sub

    Public Sub AltaLineaCreditoLIQUIDEZ(Cliente As String, Monto As Decimal, Notas As String)
        Try
            Dim FOLIOS As New CreditoDSTableAdapters.LlavesTableAdapter
            Dim SolStr As String = ""
            Dim Dispo As String
            Dim TaCredit As New CreditoDSTableAdapters.CreditTableAdapter
            Dim taDetSol As New CreditoDSTableAdapters.DetSolTableAdapter
            Dim TaLinea As New CreditoDSTableAdapters.CRED_LineasCreditoTableAdapter
            Dim TLinea As New CreditoDS.CRED_LineasCreditoDataTable
            TaLinea.Insert(Cliente, "", 0, Monto, "LIQUIDEZ", 2, Date.Now, Date.Now, Date.Now.AddDays(30), Notas, "Gbello")
            If taDetSol.NoSolicitudes(Cliente) = 0 Then
                Dispo = "001"
                SolStr = FOLIOS.FolioSolCre
                SolStr = Stuff(SolStr, "I", "0", 6)
                TaCredit.Insert(SolStr, Date.Now.ToString("yyyyMMdd"), 5, Date.Now.ToString("yyyyMMdd"), "", "A", Monto, Date.Now.ToString("yyyyMMdd"), "",
                                Date.Now.AddDays(30).ToString("yyyyMMdd"), Monto, "", "")
                FOLIOS.ConsumeSolCre()
            Else
                SolStr = taDetSol.SacaSolCreStr(Cliente)
                TaCredit.UpdateLinea(5, Date.Now.ToString("yyyyMMdd"), "A", Monto, Date.Now.ToString("yyyyMMdd"), Date.Now.AddDays(30).ToString("yyyyMMdd"), SolStr, 0)
                Dispo = taDetSol.NoDispo(Cliente) + 1
                Dispo = Stuff(Dispo, "I", "0", 3)
            End If
            taDetSol.InsertDispo(SolStr, Dispo, Cliente, Monto)
        Catch ex As Exception
            EnviacORREO("ecacerest@finagil.com.mx", ex.Message, "Error Alta Linea", "ecacerest@finagil.com.mx")
        End Try
    End Sub

    Public Function Stuff(ByVal Cadena As String, ByVal Lado As String, ByVal Llenarcon As String, ByVal Longitud As Integer) As String

        ' Declaración de variables de datos

        Dim cCadenaAuxiliar As String
        Dim nVeces As Integer
        Dim i As Integer

        nVeces = Longitud - Val(Len(Cadena))

        cCadenaAuxiliar = ""
        For i = 1 To nVeces
            cCadenaAuxiliar = cCadenaAuxiliar & Llenarcon
        Next
        If Lado = "D" Then
            Stuff = Cadena & cCadenaAuxiliar
        Else
            Stuff = cCadenaAuxiliar & Cadena
        End If

    End Function
End Module
