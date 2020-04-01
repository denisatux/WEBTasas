<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ConsultaEFOS.aspx.vb" Inherits="WEBTasas.ConsultaEFOS" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 239px;
            height: 104px;
        }
        #form1 {
            text-align: center;
        }
        .auto-style2 {
            text-align: left;
            width: 400px;
        }
        .auto-style4 {
            align-content: center;
            align-items: center;
            align-self: center;
            width: 802px;
            top: auto;
            bottom: auto;
            margin-right: 104px;
        }
        .auto-style6 {
            width: 400px;
        }
        .auto-style7 {
            text-align: left;
            width: 400px;
            font-family: Verdana;
        }
        .auto-style8 {
            width: 400px;
            font-family: Verdana;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width: 100%">
                <tr>
                    <td style="height: 95px; background-color: #FF8B3E; width: 100%;">
                        <asp:Label ID="LbDias" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="White" Text="Consulta de listado EFOS" Width="100%"></asp:Label>
                    </td>
                    <td style="height: 100%; background-color: #f58220; text-align: center; width: auto;">
                        <img alt="" class="auto-style1" src="file:///E:/VS_Proj/WEB_Cotizador/IMG/LOGOpeque2.JPG" /></td>
                </tr>
            </table>
        </div>
        <br />
        <asp:TextBox ID="txtConsultar" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lbError" runat="server" Font-Names="Verdana" ForeColor="Red" Text="Sintaxis del RFC incorrecta" Visible="False"></asp:Label>
        <br />
        <asp:Label ID="lbLeyendaImpresion" runat="server" Font-Names="Verdana" Font-Size="Smaller" Text="Para emitir el acuse es necesario ingresar el nombre o razón social del contribuyente:" Visible="False"></asp:Label>
        <br />
        <asp:TextBox ID="txtNombreIngresar" runat="server" Visible="False" Width="379px"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnConsultar" runat="server" Text="Consultar" />
        <br />
        <br />
        <table class="auto-style4" style="margin:auto">
            <tr>
                <td class="auto-style2" style="background-color: #FF8B3E">
                    <asp:Label ID="Label1" runat="server" Font-Names="Verdana" Text="RFC:"></asp:Label>
                </td>
                <td class="auto-style7" style="background-color: #FF8B3E">
                    <asp:Label ID="lbRFC" runat="server" Font-Names="Verdana"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style7" style="background-color: #FF8B3E">Nombre:</td>
                <td class="auto-style7" style="background-color: #FF8B3E">
                    <asp:Label ID="lbNombre" runat="server" Font-Names="Verdana"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style7" style="background-color: #FF8B3E">Tipo de persona:</td>
                <td class="auto-style7" style="background-color: #FF8B3E">
                    <asp:Label ID="lbTipoPersona" runat="server" Font-Names="Verdana"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style8">&nbsp;</td>
                <td class="auto-style6">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style8" style="border: thin groove #0000FF">Artículo 69 (Créditos fiscales)</td>
                <td class="auto-style8" style="border: thin groove #0000FF">Artículo 69 (Operaciones inexistentes)</td>
            </tr>
            <tr>
                <td class="auto-style8">&nbsp;</td>
                <td class="auto-style6">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style8"></td>
                <td class="auto-style6"></td>
            </tr>
            <tr>
                <td class="auto-style8" style="border: thin double #0000FF">
                    <asp:GridView ID="GridView1" runat="server" HorizontalAlign="Center">
                        <EditRowStyle Font-Names="Verdana" />
                        <FooterStyle Font-Names="Verdana" />
                        <HeaderStyle Font-Names="Verdana" />
                        <RowStyle Font-Names="Verdana" />
                    </asp:GridView>
                    <br />
                    <asp:Label ID="lbExiste69" runat="server" Font-Bold="True" ForeColor="#009933"></asp:Label>
                </td>
                <td class="auto-style8" style="border: thin double #0000FF">
                    <asp:GridView ID="GridView2" runat="server" HorizontalAlign="Center">
                    </asp:GridView>
                    <br />
                    <asp:Label ID="lbExiste69B" runat="server" Font-Bold="True" ForeColor="#009933"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Imprimir Acuse" Visible="False" />
        <br />
        <br />
    </form>
</body>
</html>
