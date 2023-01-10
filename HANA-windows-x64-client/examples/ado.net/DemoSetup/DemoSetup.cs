using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using Sap.Data.Hana;

namespace DemoSetup
{
    public partial class Form1 : Form
    {
	private HanaConnection _conn;
	private System.Windows.Forms.Button btnConnect;
	private System.Windows.Forms.Button btnCreate;
	private System.Windows.Forms.Button btnDestroy;
	private System.Windows.Forms.Button btnDisconnect;
	private System.Windows.Forms.Label label1;
	private System.Windows.Forms.TextBox txtConnectString;
	private System.Windows.Forms.Label label2;
	private System.Windows.Forms.TextBox txtFilePath;
	private System.Windows.Forms.Label label3;
	private System.Windows.Forms.ListBox listBoxTables;

	/// <summary>
	/// Required designer variable.
	/// </summary>
	private System.ComponentModel.IContainer components = null;

	public Form1()
	{
	    InitializeComponent();

	    String filepath = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase);
	    filepath = filepath.Replace("file:\\", "");
	    if (File.Exists(filepath + "\\..\\..\\TankTop.jpg"))
	    {
		txtFilePath.Text = System.IO.Directory.GetParent(filepath + "\\..").ToString();
	    }
	    else if (File.Exists(filepath + "\\..\\TankTop.jpg"))
	    {
		txtFilePath.Text = System.IO.Directory.GetParent(filepath).ToString();
	    }
	    else if (File.Exists(filepath + "\\TankTop.jpg"))
	    {
		txtFilePath.Text = filepath;
	    }
	    else
	    {
		txtFilePath.Text = "Script files not found";
	    }
	}

	/// <summary>
	/// Clean up any resources being used.
	/// </summary>
	/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
	protected override void Dispose(bool disposing)
	{
	    if( _conn != null && _conn.State == ConnectionState.Open ) 
	    {
		_conn.Close();
	    }
	    if (disposing && (components != null))
	    {
		components.Dispose();
	    }
	    base.Dispose(disposing);
	}

	#region Windows Form Designer generated code
	/// <summary>
	/// Required method for Designer support - do not modify
	/// the contents of this method with the code editor.
	/// </summary>
	private void InitializeComponent()
	{
	    this.btnConnect = new System.Windows.Forms.Button();
	    this.btnDisconnect = new System.Windows.Forms.Button();
	    this.label1 = new System.Windows.Forms.Label();
	    this.txtConnectString = new System.Windows.Forms.TextBox();
	    this.txtFilePath = new System.Windows.Forms.TextBox();
	    this.label2 = new System.Windows.Forms.Label();
	    this.listBoxTables = new System.Windows.Forms.ListBox();
	    this.btnDestroy = new System.Windows.Forms.Button();
	    this.btnCreate = new System.Windows.Forms.Button();
	    this.label3 = new System.Windows.Forms.Label();
	    this.SuspendLayout();
	    // 
	    // btnConnect
	    // 
	    this.btnConnect.Location = new System.Drawing.Point(15, 12);
	    this.btnConnect.Name = "btnConnect";
	    this.btnConnect.Size = new System.Drawing.Size(150, 23);
	    this.btnConnect.TabIndex = 2;
	    this.btnConnect.Text = "&Connect";
	    this.btnConnect.UseVisualStyleBackColor = true;
	    this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
	    // 
	    // btnDisconnect
	    // 
	    this.btnDisconnect.Location = new System.Drawing.Point(570, 12);
	    this.btnDisconnect.Name = "btnDisconnect";
	    this.btnDisconnect.Size = new System.Drawing.Size(150, 23);
	    this.btnDisconnect.TabIndex = 4;
	    this.btnDisconnect.Text = "Disconnect";
	    this.btnDisconnect.UseVisualStyleBackColor = true;
	    this.btnDisconnect.Click += new System.EventHandler(this.btnDisconnect_Click);
	    // 
	    // label1
	    // 
	    this.label1.AutoSize = true;
	    this.label1.Location = new System.Drawing.Point(15, 47);
	    this.label1.Name = "label1";
	    this.label1.Size = new System.Drawing.Size(94, 13);
	    this.label1.TabIndex = 7;
	    this.label1.Text = "Connection String:";
	    // 
	    // txtConnectString
	    // 
	    this.txtConnectString.Location = new System.Drawing.Point(15, 63);
	    this.txtConnectString.Name = "txtConnectString";
	    this.txtConnectString.Size = new System.Drawing.Size(740, 20);
	    this.txtConnectString.TabIndex = 6;
	    this.txtConnectString.Text = "Server=hana-server:30015;UserID=username;Password=passcode";
	    // 
	    // txtFilePath
	    // 
	    this.txtFilePath.Location = new System.Drawing.Point(15, 114);
	    this.txtFilePath.Name = "txtFilePath";
	    this.txtFilePath.Size = new System.Drawing.Size(740, 20);
	    this.txtFilePath.TabIndex = 8;
	    this.txtFilePath.Text = "C:\\Program Files\\SAP\\hdbclient\\Examples\\ADO.NET\\DemoSetup";
	    // 
	    // label2
	    // 
	    this.label2.AutoSize = true;
	    this.label2.Location = new System.Drawing.Point(15, 98);
	    this.label2.Name = "label2";
	    this.label2.Size = new System.Drawing.Size(77, 13);
	    this.label2.TabIndex = 9;
	    this.label2.Text = "Script file path:";
	    // 
	    // listBoxTables
	    // 
	    this.listBoxTables.FormattingEnabled = true;
	    this.listBoxTables.Location = new System.Drawing.Point(15, 165);
	    this.listBoxTables.Name = "listBoxTables";
	    this.listBoxTables.Size = new System.Drawing.Size(740, 277);
	    this.listBoxTables.TabIndex = 11;
	    // 
	    // btnDestroy
	    // 
	    this.btnDestroy.Location = new System.Drawing.Point(385, 12);
	    this.btnDestroy.Name = "btnDestroy";
	    this.btnDestroy.Size = new System.Drawing.Size(150, 23);
	    this.btnDestroy.TabIndex = 13;
	    this.btnDestroy.Text = "Remove demo objects";
	    this.btnDestroy.UseVisualStyleBackColor = true;
	    this.btnDestroy.Click += new System.EventHandler(this.btnDestroy_Click);
	    // 
	    // btnCreate
	    // 
	    this.btnCreate.Location = new System.Drawing.Point(200, 12);
	    this.btnCreate.Name = "btnCreate";
	    this.btnCreate.Size = new System.Drawing.Size(150, 23);
	    this.btnCreate.TabIndex = 12;
	    this.btnCreate.Text = "Create demo objects";
	    this.btnCreate.UseVisualStyleBackColor = true;
	    this.btnCreate.Click += new System.EventHandler(this.btnCreate_Click);
	    // 
	    // label3
	    // 
	    this.label3.AutoSize = true;
	    this.label3.Location = new System.Drawing.Point(15, 149);
	    this.label3.Name = "label3";
	    this.label3.Size = new System.Drawing.Size(202, 13);
	    this.label3.TabIndex = 14;
	    this.label3.Text = "Current DEMO tables, views, procedures:";
	    // 
	    // Form1
	    // 
	    this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
	    this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
	    this.ClientSize = new System.Drawing.Size(768, 466);
	    this.Controls.Add(this.label3);
	    this.Controls.Add(this.btnDestroy);
	    this.Controls.Add(this.btnCreate);
	    this.Controls.Add(this.listBoxTables);
	    this.Controls.Add(this.label2);
	    this.Controls.Add(this.txtFilePath);
	    this.Controls.Add(this.label1);
	    this.Controls.Add(this.txtConnectString);
	    this.Controls.Add(this.btnDisconnect);
	    this.Controls.Add(this.btnConnect);
	    this.Name = "Form1";
	    this.Text = "Create the SAP HANA .NET Data Provider demostration tables, views, and procedures" +
    "";
	    this.ResumeLayout(false);
	    this.PerformLayout();

	}
	#endregion

	/// <summary>
	/// The main entry point for the application.
	/// </summary>
	[STAThread]
	static void Main()
	{
	    Application.EnableVisualStyles();
	    Application.SetCompatibleTextRenderingDefault(false);
	    Application.Run(new Form1());
	}

	private void UpdateProducts()
	{
	
	    int[] ProductIDs = new int[10] 
	    { 300, 301, 302, 400, 401, 500, 501, 600, 601, 700 };
	    String[] PhotoFiles = new String[10] 
	    {
		"TankTop.jpg",
		"V-Neck.jpg",
		"CrewNeck.jpg",
		"CottonCap.jpg",
		"WoolCap.jpg",
		"ClothVisor.jpg",
		"PlasticVisor.jpg",
		"HoodedSweatshirt.jpg",
		"ZippedSweatshirt.jpg",
		"CottonShorts.jpg"
	    };

	    HanaCommand updateCmd = new HanaCommand(
		"UPDATE DEMO.Products SET Photo = ? " +
		"WHERE ID = ?", _conn);

	    HanaParameter parm = new HanaParameter();
	    parm.HanaDbType = HanaDbType.Blob;
	    updateCmd.Parameters.Add(parm);

	    parm = new HanaParameter();
	    parm.HanaDbType = HanaDbType.Integer;
	    updateCmd.Parameters.Add(parm);

	    for (int i = 0; i < 10; i++)
	    {
		try
		{
		    int key = ProductIDs[i];
		    byte[] data = File.ReadAllBytes(txtFilePath.Text + "\\" + PhotoFiles[i]);

		    updateCmd.Parameters[0].Value = data;
		    updateCmd.Parameters[1].Value = key;

		    int recordsAffected = updateCmd.ExecuteNonQuery();
		}
		catch (HanaException ex)
		{
		    var result = MessageBox.Show( ex.Errors[0].Source + " : " + ex.Errors[0].Message + " (" +
			ex.Errors[0].NativeError.ToString() + ")\n\n" +
			"Continue?",
			"Failed to update table",
			MessageBoxButtons.YesNo,
			MessageBoxIcon.Question);
		    if (result == DialogResult.No) break;
		}
	    }
	}

	private bool Batch( String filename )
	{
	    bool code = true;

	    if (_conn == null)
	    {
		MessageBox.Show("Connect to server first");
		return false;
	    }

	    // Set cursor as hourglass (or rotating circle)
	    Cursor.Current = Cursors.WaitCursor;

	    String filepath = txtFilePath.Text + "\\" + filename;

	    try
	    {
		int line = 0;
		bool timeToExecute = false;
		bool timeToQuit = false;
		bool storedProc = false;
		String sqlBatch = "";

		using (StreamReader sr = new StreamReader(filepath))
		{
		    while (!timeToQuit)
		    {
			if (sr.Peek() >= 0)
			{
			    char[] charsToTrim = { ' ', '\t' };
			    String sqlStatement = sr.ReadLine();
			    line++;
			    sqlStatement = sqlStatement.Trim(charsToTrim);
			    sqlStatement = sqlStatement.Replace('\t', ' ');
			    sqlStatement = sqlStatement.Replace("        ", " ");
			    sqlStatement = sqlStatement.Replace("       ", " ");
			    sqlStatement = sqlStatement.Replace("      ", " ");
			    sqlStatement = sqlStatement.Replace("     ", " ");
			    sqlStatement = sqlStatement.Replace("    ", " ");
			    sqlStatement = sqlStatement.Replace("   ", " ");
			    sqlStatement = sqlStatement.Replace("  ", " ");
			    if (sqlStatement.Length == 0)
			    {
				// Skip blank lines
			    }
			    else if (sqlStatement.ToUpper().Contains("-- INSERT PHOTOS HERE"))
			    {
				UpdateProducts();
			    }
			    else if (sqlStatement.StartsWith("--"))
			    {
				// Skip comments
			    }
			    else if (sqlStatement.ToUpper().Contains("CREATE FUNCTION ") ||
				sqlStatement.ToUpper().Contains("CREATE PROCEDURE "))
			    {
				sqlBatch += sqlStatement + " ";
				storedProc = true;
			    }
			    else if (sqlStatement.ToUpper().Contains("END#") && storedProc)
			    {
				sqlBatch += sqlStatement.Trim('#');
				storedProc = false;
				timeToExecute = true;
			    }
			    else if ((sqlStatement.LastIndexOf('#') == sqlStatement.Length - 1) && !storedProc)
			    {
				sqlBatch += sqlStatement.Trim('#');
				timeToExecute = true;
			    }
			    else
			    {
				sqlBatch += sqlStatement + " ";
			    }
			}
			else
			{
			    // Check for unexecuted fragment at end of file
			    if (sqlBatch.Length > 0)
			    {
				timeToExecute = true;
			    }
			    timeToQuit = true;
			}
			if (timeToExecute)
			{
			    try
			    {
				HanaCommand cmd = new HanaCommand(sqlBatch, _conn);
				cmd.ExecuteNonQuery();
				cmd.Dispose();
			    }
			    catch (HanaException ex)
			    {
				var result = MessageBox.Show("Line " + line.ToString() + " : " +
				    ex.Errors[0].Source + " : " + ex.Errors[0].Message + " (" +
				    ex.Errors[0].NativeError.ToString() + ")\n\n" +
				    sqlBatch + "\n\nContinue?",
				    "Failed to execute SQL statement",
				    MessageBoxButtons.YesNo,
				    MessageBoxIcon.Question);
				if (result == DialogResult.No)
				{
				    timeToQuit = true;
				}
				code = false;
			    }
			    timeToExecute = false;
			    sqlBatch = "";
			}
		    }
		}
	    }
	    catch (Exception ex)
	    {
		MessageBox.Show("Error opening/reading file " + filename + "\n" + ex.Message, "DemoSetup");
		code = false;
	    }

	    // Set cursor back to default
	    Cursor.Current = Cursors.Default;
	    return code;
	}

	private void ShowObjects()
	{
	    if (_conn == null) return;

	    HanaCommand cmd = new HanaCommand("SELECT schema_name,table_name FROM sys.tables WHERE schema_name = 'DEMO'", _conn);
	    HanaDataReader dr = cmd.ExecuteReader();

	    listBoxTables.Items.Clear();
	    listBoxTables.Items.Add("--Tables--");
	    while (dr.Read())
	    {
		listBoxTables.Items.Add(dr.GetString(0) + '.' + dr.GetString(1));
	    }
	    dr.Close();
	    listBoxTables.Items.Add("--Views--");
	    cmd.CommandText = "SELECT schema_name,view_name FROM sys.views WHERE schema_name = 'DEMO'";
	    dr = cmd.ExecuteReader();
	    while (dr.Read())
	    {
		listBoxTables.Items.Add(dr.GetString(0) + '.' + dr.GetString(1));
	    }
	    dr.Close();
	    listBoxTables.Items.Add("--Procedures--");
	    cmd.CommandText = "SELECT schema_name, procedure_name FROM sys.procedures WHERE schema_name = 'DEMO'";
	    dr = cmd.ExecuteReader();
	    while (dr.Read())
	    {
		listBoxTables.Items.Add(dr.GetString(0) + '.' + dr.GetString(1));
	    }
	    dr.Close();
	}

	private void btnConnect_Click(object sender, EventArgs e)
	{
	    try
	    {
		if ( (_conn != null) && (_conn.State == ConnectionState.Open) )
		{
		    MessageBox.Show("Connection already open", "DemoSetup");
		    return;
		}
		_conn = new HanaConnection(txtConnectString.Text);
		_conn.Open();
		ShowObjects();
	    }
	    catch (HanaException ex)
	    {
		MessageBox.Show(ex.Errors[0].Source + " : " + ex.Errors[0].Message + " (" +
				 ex.Errors[0].NativeError.ToString() + ")",
				 "Failed to connect");
	    }
		catch ( TypeInitializationException ex )
		{
			MessageBox.Show( ex.InnerException.Source + " : " + ex.InnerException.Message,
				 "Failed to load HANA ADO.NET Provider, can't find native DLL" );
		}
	}

	private void btnCreate_Click(object sender, EventArgs e)
	{
	    if (Batch("mkdemo.sql"))
	    {
		MessageBox.Show("Demo tables/views/procedures created", "DemoSetup");
	    }
	    ShowObjects();
	}

	private void btnDestroy_Click(object sender, EventArgs e)
	{
	    if (Batch("undemo.sql"))
	    {
		MessageBox.Show("Demo tables/views/procedures removed", "DemoSetup");
	    }
	    ShowObjects();
	}

	private void btnDisconnect_Click(object sender, EventArgs e)
	{
	    if (_conn.State == ConnectionState.Open)
	    {
		_conn.Close();
		MessageBox.Show("Connection closed", "DemoSetup");
		listBoxTables.Items.Clear();
	    }
	}

    }
}
