namespace DemoSetup
{
    partial class Form1
    {
	/// <summary>
	/// Required designer variable.
	/// </summary>
	private System.ComponentModel.IContainer components = null;

	/// <summary>
	/// Clean up any resources being used.
	/// </summary>
	/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
	protected override void Dispose(bool disposing)
	{
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
	    this.txtFilePath.Text = "C:\\Program Files\\SAP\\hdbclient\\Examples\\DemoSetup";
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
    }
}

