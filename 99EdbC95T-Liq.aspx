<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="99EdbC95T-Liq.aspx.vb" Inherits="WEBTasas.ASPX_Liquidez" %>

<%@ Register Assembly="RoderoLib" Namespace="RoderoLib" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Solicitud de Ministraciones</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width=100%>
    <tr>
    <td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #ff6600; text-align: center">
        <br />
        Adeudos de Contratos de Liquidez Inmediata por Empresa<br />
        <br />
        Estos datos no son exactos, favor de Verificar el importe correcto con su ejecutivo.</td>
    </tr>
        <tr>
    <td align=center>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ObjectDataSource1" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None" DataKeyNames="Contrato">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Cliente" HeaderText="Cliente" SortExpression="Cliente" />
                <asp:BoundField DataField="Contrato" HeaderText="Contrato" SortExpression="Contrato" ReadOnly="True" />
                <asp:BoundField DataField="MontoFinanciado" DataFormatString="{0:n2}" HeaderText="Monto Financiado" HtmlEncode="False" ReadOnly="True" SortExpression="MontoFinanciado">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Saldo" DataFormatString="{0:n2}" HeaderText="Saldo Insoluto" HtmlEncode="False" ReadOnly="True" SortExpression="Saldo">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="AdeudoTotal" HeaderText="Adeudo Total" SortExpression="AdeudoTotal" DataFormatString="{0:n2}" HtmlEncode="False" ReadOnly="True" >
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="CNEmpresa" HeaderText="Empresa" SortExpression="CNEmpresa">
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.Vw_RPT_LiquidezTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="Nada" Name="Empresa" QueryStringField="Empresa" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <br />
        <asp:Label ID="LbError" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#FF6600"
            Text="Sin Datos"></asp:Label>
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
