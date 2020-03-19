using System;
using System.Diagnostics;
using System.Windows.Forms;
using System.IO;

class BatCaller 
{
    static void Main(string[] args) 
    {   
        // fsleyes.bat should be in the same folder as fsleyes.exe
        var batFile = System.Reflection.Assembly.GetEntryAssembly().Location.Replace(".exe", ".bat");
        if (!File.Exists(batFile)) 
        {
            MessageBox.Show("fsleyes.bat not found in setup directory.", "Critical error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            System.Environment.Exit(42);
        }
        // ..same goes for fsleyes_wrapper.sh
        var wrapperScript = System.Reflection.Assembly.GetEntryAssembly().Location.Replace(".exe", "_wrapper.sh");
        if (!File.Exists(wrapperScript)) 
        {
            MessageBox.Show("fsleyes_wrapper.sh not found in setup directory.", "Critical error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            System.Environment.Exit(42);
        }

        string niiPath = " ";
        // was an image path provided?
        if (!(args == null || args.Length == 0)) 
        {
            niiPath = args[0];
        }
        // Execute fsleyes.bat
        var processInfo = new ProcessStartInfo("powershell.exe", batFile + " " + wrapperScript + " " + niiPath);

        processInfo.CreateNoWindow = true;
        processInfo.UseShellExecute = false;
        processInfo.RedirectStandardError = true;
        processInfo.RedirectStandardOutput = true;

        var process = Process.Start(processInfo);
        process.OutputDataReceived += (object sender, DataReceivedEventArgs e) => Console.WriteLine("output>>" + e.Data);
        process.BeginOutputReadLine();

        process.ErrorDataReceived += (object sender, DataReceivedEventArgs e) => Console.WriteLine("error>>" + e.Data);
        process.BeginErrorReadLine();

        process.WaitForExit();

        Console.WriteLine("ExitCode: {0}", process.ExitCode);
        process.Close();
    }
}