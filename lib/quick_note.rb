# Author: Pedro Jafet Avalos Jimenez
# Date:   2019-12-22

class QuickNote
    # Actual parent folder that is given by the user.
    @@parent_folder = ''

    # First command to use.
    # Creates the directory at the given directory (or the default of c:/quick_notes).
    def self.mkdir(directory='c:/quick_notes')
        # Remove the '/' at the end of the directory if it was given by the user.
        # Makes the strings in my code easier to read in my opinion.
        directory = directory[0..-2] if directory[-1] == '/'

        # Saves the given directory as the actual parent folder being used.
        @@parent_folder = directory

        # Create the directory if it doesn't already exist
        Dir.mkdir(@@parent_folder) if !Dir.exist?(@@parent_folder)
        # Creates the 'general' folder under the directory if it doesn't already exist.
        Dir.mkdir("#{@@parent_folder}/general") if !Dir.exist?("#{@@parent_folder}/general")
    end

    # Same as opfolder, but more readable.
    # In case the user wants to open the parent folder.
    def self.opdir()
        # Default parameter for opfolder() already opens the parent folder. 
        opfolder()
    end

    # Command to create a folder.
    def self.mkfolder(folder)
        # Check to make sure the parent folder exists (in case the user did not use mkdir first).
        mkdir() if @@parent_folder == ''
        # Create the folder if it doesn't exist.
        Dir.mkdir("#{@@parent_folder}/#{folder}") if !Dir.exist?("#{@@parent_folder}/#{folder}")
    end

    # Command to list all the folders in the directory.
    # Should print out the names of them.
    def self.lstfolders()
        # Check to make sure the parent folder exists (in case the user did not use mkdir first).
        mkdir() if @@parent_folder == ''
        # Make the directory the working directory.
        Dir.chdir(@@parent_folder)

        # The folders in the directory.
        folders = Dir.glob('*').select {|f| File.directory?(f)}
        
        # Make the terminal print out the various folders.
        folders.each {|f| system "echo #{f}"}
    end

    # Create a todo-type of task in a default tasks.txt file in the directory.
    def self.mktask(task, date=Time.now.strftime('%Y-%m-%d'), due_date=Time.now.strftime('%Y-%m-%d'))
        # Check to make sure the parent folder exists (in case the user did not use mkdir first).
        mkdir() if @@parent_folder == ''

        # Open (or create) the file for tasks (tasks.txt under the general folder).
        # Append the task to do in the tasks.txt file.
        File.open("#{@@parent_folder}/general/tasks.txt", 'a') {|f| f.write "date: #{date} | due: #{due_date} | task: #{task}\n"}
    end

    # Check all the tasks to do.
    # Opens the tasks.txt file with notepad.
    # An easier to read option instead of opfile()
    def self.optodo()
        # The default parameters for opnote() are already tasks.txt and general
        opnote()
    end

    # Create a note with the given name and in a given folder
    # If it exists already, then open it.
    # By default, the folder is general.
    def self.mknote(name, folder='general')
        # Check to make sure the parent folder exists (in case the user did not use mkdir first).
        mkdir() if @@parent_folder == ''

        if name != ''
            # The note file to open.
            file = "#{@@parent_folder}/#{folder}/#{name}.txt"

            # Create the folder given if it doesn't already exist.
            Dir.mkdir("#{@@parent_folder}/#{folder}") if !Dir.exist?("#{@@parent_folder}/#{folder}")
            # Create the file with the given information if it doesn't already exist.
            File.new("#{file}", File::CREAT) if !File.exist?("#{file}")

            # Tell the terminal to start the file.
            system %{cmd /c "start #{file}"}
        end
    end

    # List all the notes in a folder (general by default).
    def self.lstnotes(folder='general')
        # Check to make sure the parent folder exists (in case the user did not use mkdir first).
        mkdir() if @@parent_folder == ''

        # Make the directory the working directory.
        Dir.chdir("#{@@parent_folder}/#{folder}")

        # The folders in the directory.
        files = Dir.glob('*.txt')
        
        # Make the terminal print out the various folders.
        files.each {|f| system "echo #{f}"}
    end

    # Delete a note.
    def self.delnote(name, folder='general')
        # Check to make sure the parent folder exists (in case the user did not use mkdir first).
        mkdir() if @@parent_folder == ''

        # Delete the note if it exists.
        File.delete("#{@@parent_folder}/#{folder}/#{name}.txt") if File.exist?("#{@@parent_folder}/#{folder}/#{name}.txt")
    end

    # Delete a folder.
    def self.delfolder(folder='')
        # Check to make sure the parent folder exists (in case the user did not use mkdir first).
        mkdir() if @@parent_folder == ''

        # Delete the folder if it exists, and if the user inputs something.
        # Otherwise it would delete the whole directory.
        Dir.delete("#{@@parent_folder}/#{folder}") if Dir.exist?("#{@@parent_folder}/#{folder}") && folder != ''
    end

    # Open a folder file explorer.
    # If none is specified, then open the directory.
    def self.opfolder(folder='')
        # Check to make sure the parent folder exists (in case the user did not use mkdir first).
        mkdir() if @@parent_folder == ''

        # Terminal opens the folder with file explorer.
        system %{cmd /c "start #{@@parent_folder}/#{folder}"}
    end

    # Open a file (tasks by default) in notepad if it exists.
    def self.opnote(name='tasks', folder='general')
        # Check to make sure the parent folder exists (in case the user did not use mkdir first).
        mkdir() if @@parent_folder == ''

        # The note file to open.
        file = "#{@@parent_folder}/#{folder}/#{name}.txt"

        # Tell the terminal to start the file if it exists.
        system %{cmd /c "start #{file}"} if File.exist?(file)
    end

    # Clear all the tasks in the tasks.txt file.
    def self.clrtodo()
        # Check to make sure the parent folder exists (in case the user did not use mkdir first).
        mkdir() if @@parent_folder == ''

        # File directory.
        file = "#{@@parent_folder}/general/tasks.txt"

        # Clear the text file.
        File.write(file, '')
    end
end