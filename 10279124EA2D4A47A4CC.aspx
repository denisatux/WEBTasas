<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="10279124EA2D4A47A4CC.aspx.vb" Inherits="WEBTasas.CRED_SEGUI" %>

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
        <asp:Label ID="Label1" runat="server" Text="Estatus de Seguimientos"></asp:Label>
        <br />
        </td>
    </tr>
        <tr>
    <td align=center>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ObjectDataSource1" EnableModelValidation="True" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Responsable" HeaderText="Responsable" SortExpression="Responsable" />
                <asp:BoundField DataField="Anexo" HeaderText="Anexo" SortExpression="Anexo" ReadOnly="True" />
                <asp:BoundField DataField="Cliente" HeaderText="Cliente" SortExpression="Cliente" />
                <asp:BoundField DataField="Compromiso" HeaderText="Compromiso" SortExpression="Compromiso">
                </asp:BoundField>
                <asp:BoundField DataField="Fecha_Alta" DataFormatString="{0:d}" HeaderText="Fecha Alta" HtmlEncode="False" SortExpression="Fecha_Alta" />
                <asp:BoundField DataField="Fecha_Compromiso" DataFormatString="{0:d}" HeaderText="Fecha Compromiso" HtmlEncode="False" SortExpression="Fecha_Compromiso" />
                <asp:BoundField DataField="Analista" HeaderText="Analista" SortExpression="Analista" />
                <asp:BoundField DataField="Estatus" HeaderText="Estatus" SortExpression="Estatus" />
                <asp:BoundField DataField="DiasRetraso" HeaderText="Dias de Retraso" ReadOnly="True" SortExpression="DiasRetraso">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Tipo" HeaderText="Tipo" ReadOnly="True" SortExpression="Tipo" />
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.ProDSTableAdapters.CRED_SeguimientosTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="Depto" SessionField="Depto" Type="String" />
                <asp:SessionParameter Name="Aux" SessionField="Aux" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <br />
    
        <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%">
        </asp:Panel>
        <br />
        <asp:Label ID="LbError" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#FF6600"
            Text="No hay nada Pendiente"></asp:Label>
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
