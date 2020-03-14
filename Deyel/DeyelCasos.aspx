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
    <table width=100% align="center">
    <tr>
    <td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #ff6600; text-align: center" colspan="2">
        <br />
        Casos Activos DEYEL
        <br />        
        </td>
    </tr>
        <tr>
    <td >
          <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="http://deyel.finagil.com.mx/" Font-Bold="True" Font-Names="verdana " Target="_blank">Deyel.finagil.com.mx</asp:HyperLink>
        </td>
        <td align="right">
        <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/Deyel/DeyelCasos.aspx" Font-Bold="True" Font-Names="verdana">Refrescar Página</asp:HyperLink>
        </td>
    </tr>
        <tr>
            <td colspan="2" align="center">
            
<asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="vwDatos_DS3" Font-Names="verdana,smaller" Font-Size="Large" ForeColor="#333333" GridLines="None" Font-Bold="True">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="CLIENTES EN PROCESO" HeaderText="CLIENTES EN PROCESO" SortExpression="CLIENTES EN PROCESO" ReadOnly="True" >
                    <ItemStyle Font-Bold="True" Font-Size="Larger" HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <EditRowStyle Font-Bold="True" Font-Size="Larger" />
                <FooterStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS3" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.DeyelDSTableAdapters.CasosTotalesNTableAdapter">
            </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
                <td align=center >
                <asp:Label ID="LbError1" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#FF6600"
            Text="CASOS ACTIVOS"></asp:Label>
        
                    <br />
                    <asp:TextBox ID="TextBox1" runat="server" Height="16px" Width="286px"></asp:TextBox>
                    <asp:Button ID="Button1" runat="server" Text="Filtrar" />
            
<asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="vwDatos_DS1" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None" Font-Bold="True" ShowFooter="True" DataKeyNames="CLIENTES EN PROCESO">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ButtonType="Image" SelectImageUrl="~/IMG/check1.JPG" ShowSelectButton="True" />
                    <asp:BoundField DataField="CLIENTES EN PROCESO" HeaderText="Casos en Proceso" SortExpression="CLIENTES EN PROCESO" ReadOnly="True" >
                    <ItemStyle Font-Bold="True" Font-Size="Smaller" HorizontalAlign="Left" />
                    </asp:BoundField>
                </Columns>
                <EditRowStyle Font-Bold="True" Font-Size="Larger" />
                <FooterStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.DeyelDSTableAdapters.CasosTotalesTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="Caso" SessionField="FILTRO" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        <br />
        <br />
    
                <br />
    </td>
            <td>

            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="vwDatos_DS2" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
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
                    <asp:BoundField DataField="AREA RESPONSABLE" HeaderText="Area " SortExpression="AREA RESPONSABLE" />
                    <asp:BoundField DataField="RESPONSABLE" HeaderText="Responsable" SortExpression="RESPONSABLE" ReadOnly="True" >
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
            <asp:ObjectDataSource ID="vwDatos_DS2" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByCASO" TypeName="WEBTasas.DeyelDSTableAdapters.CasosActivosDETTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="CASO" SessionField="CASO" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>

            </td>
    </tr>
        <tr>
            <td colspan="2" align="center">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center">

                <asp:Label ID="LbError0" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#FF6600" Text="DETALLE POR AREA"></asp:Label>        

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="AREA RESPONSABLE" DataSourceID="vwDatos_DS" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ButtonType="Image" SelectImageUrl="~/IMG/check1.JPG" ShowSelectButton="True" />
                    <asp:BoundField DataField="AREA RESPONSABLE" HeaderText="Area Responsable" SortExpression="AREA RESPONSABLE">
                    <ItemStyle Font-Bold="True" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="No_ Casos" HeaderText="No Casos por Area" SortExpression="No_ Casos">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.DeyelDSTableAdapters.CasosActivosRESUMTableAdapter"></asp:ObjectDataSource>

            </td>
            <td>

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
                    <asp:BoundField DataField="RESPONSABLE" HeaderText="Responsable" SortExpression="RESPONSABLE" ReadOnly="True" >
                    <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="FECHAINICIO" DataFormatString="{0:d}" HeaderText="Fecha Inicio" SortExpression="FECHAINICIO" >
                    </asp:BoundField>
                    <asp:BoundField DataField="AREA RESPONSABLE" HeaderText="Area" SortExpression="AREA RESPONSABLE" />
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS0" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.DeyelDSTableAdapters.CasosActivosDETTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="Area" SessionField="AREA RESPONSABLE" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>

            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <br />
            </td>
        </tr>

        <tr>
<td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #ff6600; text-align: center" colspan="2">
          
    <br />
    </td>         
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
