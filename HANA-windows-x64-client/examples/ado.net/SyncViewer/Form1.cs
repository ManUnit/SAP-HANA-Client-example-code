using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace SyncViewer
{
    public partial class Form1 : Form
    {
	public Form1()
	{
	    InitializeComponent();
	}

	private void pRODUCTSBindingNavigatorSaveItem_Click(object sender, EventArgs e)
	{
	    this.Validate();
	    this.pRODUCTSBindingSource.EndEdit();
	    this.tableAdapterManager.UpdateAll(this.dataSet1);

	}

	private void Form1_Load(object sender, EventArgs e)
	{
	    // TODO: This line of code loads data into the 'dataSet1.PRODUCTS' table. You can move, or remove it, as needed.
	    this.pRODUCTSTableAdapter.Fill(this.dataSet1.PRODUCTS);

	}

	private void fillToolStripButton_Click(object sender, EventArgs e)
	{
	    try
	    {
		this.vIEWSALESORDERSTableAdapter.Fill(this.dataSet1.VIEWSALESORDERS, ((decimal)(System.Convert.ChangeType(iDTextBox.Text, typeof(decimal)))));
	    }
	    catch (System.Exception ex)
	    {
		System.Windows.Forms.MessageBox.Show(ex.Message);
	    }

	}
    }
}
