<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Reestructuras.aspx.vb" Inherits="WEBTasas.ReestructurasForm" Culture="es-MX" uiCulture="es-MX" %>

<%@ Register Assembly="RoderoLib" Namespace="RoderoLib" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Casos Activos DEYEL</title>
    <style type="text/css">
        .auto-style1 {
            height: 39px;
        }
        .auto-style2 {
            height: 92px;
        }
        .auto-style3 {
            height: 46px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width=100% align="center">
    <tr>
    <td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #f58220; text-align: center" colspan="2">
        <br />
        Reestructuras DEYEL
        <br />        
        </td>
    </tr>
        <tr>

    <td >
          <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="http://deyel.finagil.com.mx/" Font-Bold="True" Font-Names="verdana " Target="_blank">Deyel.finagil.com.mx</asp:HyperLink>
        </td>
        <td align="right">
        <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/Deyel/Reestructuras.aspx" Font-Bold="True" Font-Names="verdana">Refrescar Página</asp:HyperLink><br />
        </td>
    </tr>
        <tr>
            <td colspan="2" align="center">

                <asp:Label ID="LbError2" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#F58220" Text="1ras Reestructuras"></asp:Label>        

                <br />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
            
<asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="vwDatos_DS3" Font-Names="verdana,smaller" Font-Size="Large" ForeColor="#333333" GridLines="None" Font-Bold="True" BorderStyle="Outset" CellSpacing="4">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="CLIENTES EN PROCESO" HeaderText="CASOS EN PROCESO" SortExpression="CLIENTES EN PROCESO" ReadOnly="True" >
                    <ItemStyle Font-Bold="True" Font-Size="Larger" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="FORMALIZADOS" SortExpression="CLIENTES EN PROCESO">
                    <ItemStyle Font-Bold="True" Font-Size="Larger" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="CLIENTE RECHAZO">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="CASOS TOTALES">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="% AVANCE" SortExpression="CLIENTES EN PROCESO">
                    <ItemStyle Font-Bold="True" Font-Size="Larger" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                </Columns>
                <EditRowStyle Font-Bold="True" Font-Size="Larger" />
                <FooterStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" BorderColor="Black" BorderStyle="Dashed" BorderWidth="1px" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS3" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByReestructuras" TypeName="WEBTasas.DeyelDSTableAdapters.CasosTotalesNTableAdapter">
            </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center" class="auto-style1">
                <br />
            </td>
        </tr>
         <tr>
            <td align="left" valign="top">

                <asp:Label ID="LbError0" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#F58220" Text="DETALLE POR ETAPA"></asp:Label>        

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="AREA RESPONSABLE" DataSourceID="vwDatos_DS" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None" CellSpacing="2">
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
                <HeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByReestructuras" TypeName="WEBTasas.DeyelDSTableAdapters.CasosActivosRESUMTableAdapter"></asp:ObjectDataSource>

            </td>
            <td valign="top">

            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="vwDatos_DS0" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None" CellSpacing="2">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="CASO" HeaderText="CASO" SortExpression="CASO" >
                    </asp:BoundField>
                    <asp:BoundField DataField="ACTIVIDAD" HeaderText="ETAPA" SortExpression="ACTIVIDAD" ReadOnly="True" >
                    </asp:BoundField>
                    <asp:BoundField DataField="FECHAINICIO" HeaderText="FECHA INICIO" SortExpression="FECHAINICIO" DataFormatString="{0:d}" >
                    </asp:BoundField>
                    <asp:BoundField DataField="IMPORTE" HeaderText="IMPORTE" SortExpression="IMPORTE" DataFormatString="{0:n2}" >
                    </asp:BoundField>
                    <asp:BoundField DataField="TIPO" HeaderText="TIPO" SortExpression="TIPO" >
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS0" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.DeyelDSTableAdapters.ReestructurasDETTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="Area" SessionField="AREA RESPONSABLE" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>

            </td>
        </tr>
        <tr>
            <td colspan="2" align="center" class="auto-style3">
                <br />

                <asp:Label ID="LbError3" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#F58220" Text="2das Reestructuras"></asp:Label>        

            </td>
        </tr>
                <tr>
            <td colspan="2" align="center">
            
<asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="vwDatos_DS4" Font-Names="verdana,smaller" Font-Size="Large" ForeColor="#333333" GridLines="None" Font-Bold="True" BorderStyle="Outset" CellSpacing="4">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="CLIENTES EN PROCESO" HeaderText="CASOS EN PROCESO" SortExpression="CLIENTES EN PROCESO" ReadOnly="True" >
                    <ItemStyle Font-Bold="True" Font-Size="Larger" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="FORMALIZADOS" SortExpression="CLIENTES EN PROCESO">
                    <ItemStyle Font-Bold="True" Font-Size="Larger" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="CLIENTE RECHAZO">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="CASOS TOTALES">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="% AVANCE" SortExpression="CLIENTES EN PROCESO">
                    <ItemStyle Font-Bold="True" Font-Size="Larger" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                </Columns>
                <EditRowStyle Font-Bold="True" Font-Size="Larger" />
                <FooterStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" BorderColor="Black" BorderStyle="Dashed" BorderWidth="1px" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS4" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByReestructuras" TypeName="WEBTasas.DeyelDSTableAdapters.CasosTotalesN2TableAdapter">
            </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center" class="auto-style1">
                <br />
            </td>
        </tr>
         <tr>
            <td align="left" valign="top">

                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#F58220" Text="DETALLE POR ETAPA"></asp:Label>        

            <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="AREA RESPONSABLE" DataSourceID="vwDatos_DS5" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None" CellSpacing="2">
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
                <HeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS5" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByReestructuras" TypeName="WEBTasas.DeyelDSTableAdapters.CasosActivosRESUM2TableAdapter"></asp:ObjectDataSource>

            </td>
            <td valign="top">

            <asp:GridView ID="GridView8" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="vwDatos_DS6" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None" CellSpacing="2">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="CASO" HeaderText="CASO" SortExpression="CASO" >
                    </asp:BoundField>
                    <asp:BoundField DataField="ACTIVIDAD" HeaderText="ETAPA" SortExpression="ACTIVIDAD" ReadOnly="True" >
                    </asp:BoundField>
                    <asp:BoundField DataField="FECHAINICIO" HeaderText="FECHA INICIO" SortExpression="FECHAINICIO" DataFormatString="{0:d}" >
                    </asp:BoundField>
                    <asp:BoundField DataField="IMPORTE" HeaderText="IMPORTE" SortExpression="IMPORTE" DataFormatString="{0:n2}" >
                    </asp:BoundField>
                    <asp:BoundField DataField="TIPO" HeaderText="TIPO" SortExpression="TIPO" >
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS6" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="WEBTasas.DeyelDSTableAdapters.ReestructurasDET2TableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="Area" SessionField="AREA RESPONSABLE2" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>

            </td>
        </tr>
        <tr>
            <td colspan="2" align="center" class="auto-style2">
                <br />
            </td>
        </tr>
        <tr>
                <td align=left valign="top" >
                <asp:Label ID="LbError1" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#f58220"
            Text="CASOS ACTIVOS"></asp:Label>
        
                    <br />
                    <asp:TextBox ID="TextBox1" runat="server" Height="16px" Width="286px"></asp:TextBox>
                    <asp:Button ID="Button1" runat="server" Text="Filtrar" />
            
<asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="vwDatos_DS1" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None" Font-Bold="True" ShowFooter="True" DataKeyNames="CLIENTES EN PROCESO" AllowPaging="True" CellSpacing="2">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ButtonType="Image" SelectImageUrl="~/IMG/check1.JPG" ShowSelectButton="True" />
                    <asp:BoundField DataField="CLIENTES EN PROCESO" HeaderText="Casos en Proceso" SortExpression="CLIENTES EN PROCESO" ReadOnly="True" >
                    <ItemStyle Font-Bold="True" Font-Size="Smaller" HorizontalAlign="Left" />
                    </asp:BoundField>
                </Columns>
                <EditRowStyle Font-Bold="True" Font-Size="Larger" />
                <FooterStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByReestructuras" TypeName="WEBTasas.DeyelDSTableAdapters.CasosTotalesTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="Caso" SessionField="FILTRO" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        <br />
        <br />
    
                <br />
    </td>
            <td valign="top">

            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="vwDatos_DS2" Font-Names="verdana,smaller" Font-Size="Smaller" ForeColor="#333333" GridLines="None" CellSpacing="2">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="CASO" HeaderText="CASO" SortExpression="CASO" >
                    </asp:BoundField>
                    <asp:BoundField DataField="ACTIVIDAD" HeaderText="ETAPA" SortExpression="ACTIVIDAD" ReadOnly="True" >
                    </asp:BoundField>
                    <asp:BoundField DataField="FECHAINICIO" HeaderText="FECHA INICIO" SortExpression="FECHAINICIO" DataFormatString="{0:d}" HtmlEncode="False" >
                    </asp:BoundField>
                    <asp:BoundField DataField="IMPORTE" HeaderText="IMPORTE" SortExpression="IMPORTE" DataFormatString="{0:n2}" >
                    </asp:BoundField>
                    <asp:BoundField DataField="TIPO" HeaderText="TIPO" SortExpression="TIPO" />
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFE0C0" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:GridView>
            <asp:ObjectDataSource ID="vwDatos_DS2" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByCASO" TypeName="WEBTasas.DeyelDSTableAdapters.ReestructurasDETTableAdapter">
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
<td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #f58220; text-align: center" colspan="2">
          
    <br />
    </td>         
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
