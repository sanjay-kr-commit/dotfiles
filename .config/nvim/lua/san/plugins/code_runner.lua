require('code_runner').setup({
  -- put here the commands by filetype
  filetype = {
		java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
		kotlin = "cd $dir && kotlinc $fileName && echo $fileName&& kotlin $(ls | grep *.class | grep -i ${fileName%.*})",
    python = "python3 -u",
		typescript = "deno run",
		rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
	},
})
