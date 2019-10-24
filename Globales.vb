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

    Public Sub EnviacORREO(ByVal Para As String, ByVal Mensaje As String, ByVal Asunto As String, de As String, Optional Archivo As String = "")
        Dim taCorreos As New ProDSTableAdapters.GEN_Correos_SistemaFinagilTableAdapter
        taCorreos.Insert(de, Para, Asunto, Mensaje, False, Date.Now, Archivo)
        taCorreos.Dispose()
    End Sub

    Public Sub AltaLineaCreditoLIQUIDEZ1(Cliente As String, Monto As Decimal, Notas As String, User As String, id_sol As String)
        Try
            Dim BITACORA As New ProDSTableAdapters.GEN_BitacoraFinagilTableAdapter
            Dim TaLinea As New CreditoDSTableAdapters.CRED_LineasCreditoTableAdapter
            TaLinea.Insert(Cliente, "", id_sol, Monto, "LIQUIDEZ", 2, Date.Now, Date.Now, Date.Now.AddDays(30), Notas, User)
            BITACORA.Insert(User, "WebTasas", Date.Now, "LineaCredito1", System.Environment.MachineName, Monto.ToString)
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

    Public Sub MandaCorreo(De As String, Para As String, Asunto As String, Mensaje As String, Optional Archivo As String = "")
        Dim taCorreos As New ProDSTableAdapters.GEN_Correos_SistemaFinagilTableAdapter
        taCorreos.Insert(De, Para, Asunto, Mensaje, False, Date.Now, Archivo)
        taCorreos.Dispose()
    End Sub

    Public Sub MandaCorreoFase(De As String, Fase As String, Asunto As String, Mensaje As String, Optional ByVal Archivo As String = "")
        Dim taCorreos As New ProDSTableAdapters.GEN_Correos_SistemaFinagilTableAdapter
        Dim users As New ProDSTableAdapters.CorreosFasesTableAdapter
        Dim tu As New ProDS.CorreosFasesDataTable
        Dim r As ProDS.CorreosFasesRow

        users.Fill(tu, Fase)
        For Each r In tu.Rows
            taCorreos.Insert(De, r.Correo, Asunto, Mensaje, False, Date.Now, Archivo)
        Next
        taCorreos.Dispose()
    End Sub

    Public Sub MandaCorreoPROMO(Cliente As String, Asunto As String, Mensaje As String, Jefe As Boolean, CopiaRemitente As Boolean, UsuarioGlobalCorreo As String, Optional Archivo As String = "", Optional MsgPara As Boolean = False)
        Dim users As New SeguridadDSTableAdapters.UsuariosFinagilTableAdapter
        Dim taCorreos As New ProDSTableAdapters.GEN_Correos_SistemaFinagilTableAdapter
        Dim promo As New ProDSTableAdapters.CorreoPROMOTableAdapter
        Dim tu As New ProDS.CorreoPROMODataTable
        Dim r As ProDS.CorreoPROMORow
        promo.Fill(tu, Cliente)
        If tu.Rows.Count > 0 Then
            r = tu.Rows(0)
            taCorreos.Insert(UsuarioGlobalCorreo, r.Correo, Asunto, Mensaje, False, Date.Now, Archivo)

            If CopiaRemitente = True Then
                taCorreos.Insert(UsuarioGlobalCorreo, UsuarioGlobalCorreo, Asunto, Mensaje, False, Date.Now, Archivo)
            End If
            If Jefe = True Then
                MandaCorreoFase(UsuarioGlobalCorreo, "SUB_" & r.Nombre_Sucursal.Trim, Asunto, Mensaje, Archivo)
            End If
        Else
            MandaCorreo("ecacerest@finagil.com.mx", "ecacerest@finagil.com.mx", "Sin promotor-" & Asunto, Mensaje)
        End If

        taCorreos.Dispose()
        promo.Dispose()
    End Sub
End Module
