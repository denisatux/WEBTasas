<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PaginaMasterX.Master" CodeBehind="Cotizador.aspx.vb" Inherits="WEBTasas.WebForm1" 
    title="Cotizador" %>

<%@ Register Assembly="RoderoLib" Namespace="RoderoLib" TagPrefix="cc1" %>
    
    <%@ MasterType virtualpath="~/PaginaMasterX.Master" %>
    
 <script runat="server">

    

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 100%">
        <tr>
        <td style="width: 14.28%" align=center>
            <br />
            </td>
            <td align=center  style="width: 7.14%">
            <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#FF6600"
                Text="Tipo"></asp:Label><br />
            <asp:DropDownList ID="CbmTipo" runat="server" Width="92px" AutoPostBack="True">
                <asp:ListItem Value="1">Ciudad</asp:ListItem>
                <asp:ListItem Value="2">Rural</asp:ListItem>
            </asp:DropDownList></td>
            <td align=center  style="width: 14.28%">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#FF6600"
                    Text="Plazo"></asp:Label><br />
                <asp:DropDownList ID="CmbPlazo" runat="server" Width="98px">
                    <asp:ListItem Value="6">6 Meses</asp:ListItem>
                    <asp:ListItem Value="7">7 Meses</asp:ListItem>
                    <asp:ListItem Value="8">8 Meses</asp:ListItem>
                    <asp:ListItem Value="9">9 Meses</asp:ListItem>
                    <asp:ListItem Value="10">10 Meses</asp:ListItem>
                    <asp:ListItem Value="11">11 Meses</asp:ListItem>
                    <asp:ListItem Value="11">11 Meses</asp:ListItem>
                    <asp:ListItem Selected="True" Value="12">12 Meses</asp:ListItem>
                </asp:DropDownList><br />
                <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#FF6600"
                    Text="% Crédito"></asp:Label><br />
                <asp:DropDownList ID="CmbPorcCRE" runat="server" Width="69px" AutoPostBack="True">
                </asp:DropDownList></td>
            <td align=center  style="width: 14.28%">
                <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#FF6600"
                    Text="Tipo de Cambio"></asp:Label><br />
                <asp:TextBox ID="TxtTC" runat="server" Enabled="False" Font-Bold="True" MaxLength="10"
                    Width="51px">0.00</asp:TextBox><br />
                <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#FF6600"
                    Text="Tasa anual %"></asp:Label><br />
                <asp:TextBox ID="TxtTasa" runat="server" Enabled="False" Font-Bold="True" MaxLength="10"
                    ReadOnly="True" Width="38px">16.0</asp:TextBox></td>
            <td style="width: 14.28%" align=center>
                <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#FF6600"
                    Text="Monto Total USD"></asp:Label><br />
                <asp:TextBox ID="TxtUSD" runat="server" Enabled="False" Font-Bold="True" MaxLength="10"
                    Width="100px">80.0</asp:TextBox><br />
                <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#FF6600"
                    Text="Monto Finan. USD"></asp:Label><asp:TextBox ID="TxtUSDcli" runat="server" Enabled="False"
                        Font-Bold="True" MaxLength="10" Width="100px">80.0</asp:TextBox></td>
                    <td style="width: 14.28%" align=center>
                        <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#FF6600"
                            Text="Monto Total MXP"></asp:Label>
                        <asp:TextBox ID="TxtMonto" runat="server" Enabled="False"
                                Font-Bold="True" MaxLength="10" Width="100px">0.00</asp:TextBox><br />
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#FF6600"
                            Text="Monto Finan. MXP"></asp:Label>
                        <asp:TextBox ID="TxtMontoCli" runat="server" Enabled="False"
                                Font-Bold="True" MaxLength="10" Width="100px">0.00</asp:TextBox></td>
                    <td style="width: 7.14%" align=center>
                        <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="#FF6600"
                            Text="Aportación del Cliente"></asp:Label><br />
                        <asp:TextBox ID="TxtAport" runat="server" Enabled="False"
                                Font-Bold="True" MaxLength="10" Width="100px">0.00</asp:TextBox></td>
                                 <td style="width: 14.28%" align=center>
                                 </td>
        </tr>
        <tr>
            
            <td align=center colspan=8>
                <br />
                <cc1:BotonEnviar ID="BotonEnviar1" runat="server" BackColor="#FF6600" Font-Bold="True"
                    ForeColor="White" Text="Calcular Crédito" TextoEnviando="Calculando..." Width="136px" /><br />
                <br />
                <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Small"
                    ForeColor="#FF6600" Text="NOTA: el Tipo de Cambio es Informativo."></asp:Label></td>
            
        </tr>
        <tr>
            <td align=center colspan=8>
                <br />
                <asp:Label ID="LbError" runat="server" Font-Bold="True" Font-Names="Arial" ForeColor="Red"
                    Text="Error en el monto financiado." Visible="False"></asp:Label><asp:GridView ID="GridAmortizaciones" runat="server" CellPadding="4" Font-Names="Arial"
                    ForeColor="#333333" GridLines="None" PageSize="50" Width="80%" ShowFooter="True">
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <FooterStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                <br />
            </td>
            
        </tr>
    </table>
</asp:Content>
