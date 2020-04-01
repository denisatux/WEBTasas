<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="951sb999-7xx8.aspx.vb" Inherits="WEBTasas.SUBForm" %>

<%@ Register Assembly="RoderoLib" Namespace="RoderoLib" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Autorización de Tasas</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width=100%>
    <tr>
    <td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #f58220; text-align: center">
        <br />
        Notificación de Tasas (Promoción)
        <br />
    </td>
    </tr>
        <tr>
    <td align=center>
        <br />
        <br />
        <asp:DetailsView AutoGenerateRows="False" CellPadding="4" DataKeyNames="id,Diferencia" DataSourceID="vwDatos_DS" Font-Names="Verdana" Font-Size="Smaller" ForeColor="#333333" GridLines="None" HorizontalAlign="Center" ID="DetailsView1" runat="server" Width="80%" >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <RowStyle BackColor="#FFE0C0" />
            <FieldHeaderStyle BackColor="#f58220" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <Fields>
                <asp:BoundField DataField="AnexoCon" HeaderText="Anexo" SortExpression="AnexoCon" />
                <asp:BoundField DataField="Cliente" HeaderText="Cliente" SortExpression="Cliente" />
                <asp:BoundField DataField="ComentarioPromo" HeaderText="Comentarios Promoci&#243;n"
                    ReadOnly="True" SortExpression="ComentarioPromo" />
                <asp:BoundField DataField="ComentarioRiesgos" HeaderText="Comentarios Riesgos" SortExpression="ComentarioRiesgos" />
                <asp:BoundField DataField="Tasa_Politica" HeaderText="Tasa Pol&#237;tica" SortExpression="Tasa_Politica" />
                <asp:BoundField DataField="Tasa_Solicitada" HeaderText="Tasa Solicitada" SortExpression="Tasa_Solicitada" />
                <asp:BoundField DataField="TipoCredito" HeaderText="Tipo de Cr&#233;dito" SortExpression="TipoCredito" />
                <asp:BoundField DataField="MontoFinanciado" DataFormatString="{0:c}" HeaderText="Monto Financiado"
                    HtmlEncode="False" SortExpression="MontoFinanciado" />
                <asp:BoundField DataField="FondoReserva" DataFormatString="{0:c}" HeaderText="Fondo de Reserva"
                    HtmlEncode="False" SortExpression="FondoReserva" />
                <asp:BoundField DataField="Plazo" HeaderText="Plazo" SortExpression="Plazo" />
                <asp:BoundField DataField="Tipo_Tasa" HeaderText="Tipo de Tasa" ReadOnly="True" SortExpression="Tipo_Tasa" />
                <asp:BoundField DataField="PorcentajeComision" HeaderText="% Comisi&#243;n" SortExpression="PorcentajeComision" />
                <asp:BoundField DataField="RecidualOP" HeaderText="V.R. u O.C." SortExpression="RecidualOP" />
                <asp:BoundField DataField="Penalizacion" HeaderText="Penalizaci&#243;n" SortExpression="Penalizacion" />
                <asp:BoundField DataField="RentasenDeposito" HeaderText="Rentas en Dep&#243;sito"
                    SortExpression="RentasenDeposito" />
                <asp:BoundField DataField="DespoitoenGarantia" HeaderText="Desposito en Garant&#237;a"
                    SortExpression="DespoitoenGarantia" />
            </Fields>
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:DetailsView>
        <asp:ObjectDataSource ID="vwDatos_DS" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetDataByDG" TypeName="WEBTasas.ProDSTableAdapters.VWBloqueoTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
    
        <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%">
            <br />
            <cc1:BotonEnviar ID="BotonEnviar1" runat="server" Font-Bold="True" Text="Enterado"
                TextoEnviando="Enterado..." Width="122px" Font-Size="Smaller" /><br />
            <br />
        </asp:Panel>
        <br />
        <asp:Label ID="LbError" runat="server" Font-Bold="True" Font-Names="Verdana" ForeColor="#f58220"
            Text="El contrato ya fue procesado."></asp:Label>
        <br />
    </td>
    </tr>
        <tr>
<td style="font-weight: bold; vertical-align: middle; color: white; font-family: Verdana; background-color: #f58220; text-align: center">
    <br />
    <br />
    </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
