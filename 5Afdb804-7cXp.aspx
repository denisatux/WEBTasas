<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="5Afdb804-7cXp.aspx.vb" Inherits="WEBTasas.CPXForm" %>

<%@ Register Assembly="RoderoLib" Namespace="RoderoLib" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Autorización de Gastos y Facturas</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width=100%>
    <tr>
    <td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #ff6600; text-align: center">
        <br />
        Autorizacion de Gastos Y Facturas</td>
    </tr>
        <tr>
    <td align=center>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="vwDatos_DS" EnableModelValidation="True" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None" DataKeyNames="idEmpresa,Solicitud,Estatus">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Empresa" HeaderText="Empresa" SortExpression="Empresa" />
                <asp:HyperLinkField DataNavigateUrlFields="idEmpresa,Solicitud,Estatus" DataNavigateUrlFormatString="~\tmpFinagil\CXP\{0}-{1}.pdf" DataTextField="Solicitud" DataTextFormatString="{0:n0}" HeaderText="Solicitud" Target="_blank">
                <ItemStyle Font-Bold="True" HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:HyperLinkField>
                <asp:BoundField DataField="Solicita" HeaderText="Solicitante" SortExpression="Solicita" />
                <asp:BoundField DataField="Total" DataFormatString="{0:n2}" HeaderText="Total Solicitado" HtmlEncode="False" ReadOnly="True" SortExpression="Total" />
                <asp:BoundField DataField="Estatus" HeaderText="Estatus" SortExpression="Estatus" />
                <asp:TemplateField HeaderText="Comentarios">
                    <ItemTemplate>
                        <asp:TextBox ID="TextCorreo" runat="server" Height="40px" MaxLength="1000" TextMode="MultiLine" Width="330px"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:ButtonField ButtonType="Button" CommandName="Rechazar" Text="Rechazar">
                <ItemStyle Font-Bold="True" />
                </asp:ButtonField>
                <asp:ButtonField ButtonType="Button" CommandName="Autorizar" Text="Autorizar">
                <ItemStyle Font-Bold="True" />
                </asp:ButtonField>
                <asp:ButtonField ButtonType="Button" CommandName="Correo" Text="Correo" />
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:GridView>
        <asp:ObjectDataSource ID="vwDatos_DS" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.Vw_CXP_AutorizacionesTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter Name="User" QueryStringField="User" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    
        <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%">
            &nbsp;
            </asp:Panel>
        <asp:Label ID="LbError" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#FF6600"
            Text="Sin autorizaciones Pendientes"></asp:Label>
        <br />
    </td>
    </tr>
        <tr>
<td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #ff6600; text-align: center">
    <br />
    <br />
    </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
