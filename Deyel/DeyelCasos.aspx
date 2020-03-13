<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DeyelCasos.aspx.vb" Inherits="WEBTasas.DeyelCasosForm" Culture="es-MX" uiCulture="es-MX" %>

<%@ Register Assembly="RoderoLib" Namespace="RoderoLib" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Casos Activos DEYEL</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width=100%>
    <tr>
    <td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #ff6600; text-align: center">
        <br />
        Casos Activos DEYEL</td>
    </tr>
        <tr>
    <td align=center>
        <br />
        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="http://deyel.finagil.com.mx/" Font-Bold="True" Font-Names="verdana " Target="_blank">Deyel.finagil.com.mx</asp:HyperLink>
        <br />
        <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ACTIVIDAD" DataSourceID="vwDatos_DS" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ButtonType="Image" SelectImageUrl="~/IMG/check1.JPG" ShowSelectButton="True" />
                    <asp:BoundField DataField="ACTIVIDAD" HeaderText="Actividad" SortExpression="ACTIVIDAD" >
                    <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="No_ Casos" HeaderText="No Casos" SortExpression="No_ Casos" >
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.DeyelDSTableAdapters.CasosActivosRESUMTableAdapter">
            </asp:ObjectDataSource>
        <br />
    
        <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%">
            &nbsp;
            <br />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="vwDatos_DS0" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="NO_CASO" HeaderText="No. Caso" SortExpression="NO_CASO" ReadOnly="True" >
                    <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CASO" HeaderText="Caso" SortExpression="CASO" >
                    <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="PROMOTOR" HeaderText="Promotor" SortExpression="PROMOTOR" >
                    <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ACTIVIDAD" HeaderText="Actividad" SortExpression="ACTIVIDAD" ReadOnly="True" >
                    <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="RESPOSABLE" HeaderText="Resposable" SortExpression="RESPOSABLE" ReadOnly="True" >
                    <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="FECHAINICIO" DataFormatString="{0:d}" HeaderText="Fecha Inicio" SortExpression="FECHAINICIO" >
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS0" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.DeyelDSTableAdapters.CasosActivosDETTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="ACTIVIDAD" Name="Actividad" SessionField="ACTIVIDAD" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <br />
            </asp:Panel>
        <asp:Label ID="LbError" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#FF6600"
            Text="Sin casos Pendientes"></asp:Label>
        <br />
    </td>
    </tr>
        <tr>
<td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #ff6600; text-align: center">
          
    <br />
    </td>         
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
