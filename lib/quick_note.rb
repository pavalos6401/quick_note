# Author: Pedro Jafet Avalos Jimenez
# Date:   2019-12-22

class QuickNote
    # Default directory for quick_notes.
    @@DEFAULT_DIR = 'c:/quick_notes'
    # Actual directory that is given by the user.
    @@actual_dir

    # First command to use.
    # Creates the directory at the given directory (or the default).
    def self.mkdir(directory=@@DEFAULT_DIR)
        # Remove the '/' at the end of the directory if it was given by the user.
        # Makes the strings in my code easier to read in my opinion.
        directory = directory[0..-2] if directory[-1] == '/'

        # Create the directory if it doesn't already exist
        Dir.mkdir(directory) if !Dir.exist?(directory)
        # Creates the 'general' folder under the directory if it doesn't already exist.
        Dir.mkdir("#{directory}/general") if !Dir.exist?("#{directory}/general")

        # Saves the given directory as the actual directory being used.
        @@actual_dir = directory
    end

    # Command to create a folder
    def self.mkfolder(folder)
        # Create the folder if it doesn't exist
        Dir.mkdir("#{@@actual_dir}/#{folder}") if !Dir.exist?("#{@@actual_dir}/#{folder}")
    end

    # Command to list all the folders in the directory.
    # Should print out the names of them.
    def self.lstfolders()
        # Make the directory the working directory.
        Dir.chdir(@@actual_dir)

        # The folders in the directory.
        folders = Dir.glob('*').select {|f| File.directory?(f)}
        
        # Make the terminal print out the various folders.
        folders.each {|f| system "echo #{f}"}
    end

    # Create a todo-type of task in a default tasks.txt file in the directory.
    def self.mktask(task, date=Time.now.strftime('%Y-%m-%d'), due_date=Time.now.strftime('%Y-%m-%d'))
        # Open (or create) the file for tasks (tasks.txt under the general folder).
        # Append the task to do in the tasks.txt file.
        File.open("#{@@actual_dir}/general/tasks.txt", 'a') {|f| f.write "date: #{date} | due: #{due_date} | task: #{task}\n"}
    end

    # Check all the tasks to do.
    # Opens the tasks.txt file with notepad.
    # An easier to read option instead of opfile()
    def self.optodo()
        # The default parameters for opfile() are already tasks.txt and general
        opfile()
    end

    # Create a note with the given name and in a given folder
    # If it exists already, then open it.
    # By default, the folder is general
    def self.mknote(name, folder='general')
        if name != ''
            # The note file to open.
            file = "#{@@actual_dir}/#{folder}/#{name}.txt"

            # Create the folder given if it doesn't already exist.
            Dir.mkdir("#{@@actual_dir}/#{folder}") if !Dir.exist?("#{@@actual_dir}/#{folder}")
            # Create the file with the given information if it doesn't already exist.
            File.new("#{file}", File::CREAT) if !File.exist?("#{file}")

            # Tell the terminal to start the file
            system %{cmd /c "start #{file}"}
        end
    end

    # List all the notes in a folder (general by default).
    def self.lstnotes(folder='general')
        # Make the directory the working directory.
        Dir.chdir("#{@@actual_dir}/#{folder}")

        # The folders in the directory.
        files = Dir.glob('*.txt')
        
        # Make the terminal print out the various folders.
        files.each {|f| system "echo #{f}"}
    end

    # Delete a note.
    def self.delnote(name, folder='general')
        # Delete the note if it exists.
        File.delete("#{@@actual_dir}/#{folder}/#{name}.txt") if File.exist?("#{@@actual_dir}/#{folder}/#{name}.txt")
    end

    # Delete a folder.
    def self.delfolder(folder='')
        # Delete the folder if it exists, and if the user inputs something.
        # Otherwise it would delete the whole directory.
        Dir.delete("#{@@actual_dir}/#{folder}") if Dir.exist?("#{@@actual_dir}/#{folder}") && folder != ''
    end

    # Open a folder file explorer.
    # If none is specified, then open the directory.
    def self.opfolder(folder='')
        # Terminal opens the folder with file explorer.
        system %{cmd /c "start #{@@actual_dir}/#{folder}"}
    end

    # Open a file (tasks by default) in notepad if it exists.
    def self.opfile(name='tasks', folder='general')
        # The note file to open.
        file = "#{@@actual_dir}/#{folder}/#{name}.txt"

        # Tell the terminal to start the file if it exists.
        system %{cmd /c "start #{file}"} if File.exist?(file)
    end
end