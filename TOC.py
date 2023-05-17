#!/usr/local/bin/python3
# File to generate the SUMMARY.md file for the gitbook
# - filter for gitignore
# - filter for system files
# - filter for images/ directories
#%%
import os
#%%
semesters = {
    "vwl1": "I. Semester",
    "vwl2": "II. Semester", 
    "vwl3": "III. Semester", 
    "vwl4": "IV. Semester",}


dir_names = {
    "VL_Buchfuehrung": "Buchführung",
    "VL_BWL": "BWL",
    "VL_Mathe1": "Mathe",
    "VL_VWL": "VWL ",
    "VL_Statistik1": "Statistik ",
    "VL_Wirtschaftsinformatik": "Wirtschaftsinfo",

    "VL_Mathe2": "Mathematik II",
    "VL_Statistik2": "Statistik II",
    "VL_Mikro": "Mikroökonomik",
    "VL_WissArbeit": "Wissenschaftliches Arbeiten",
    "VL_Recht-WiWi": "Recht für WiWi",
    "VL_Stadt": "Stadtökonomie (Leipzig)",

    "VL_Ethik": "Ethik der Soz. Marktwirtschaft",
    "VL_Makro1": "Makroökonomik I",
    "VL_Mikro2": "Mikroökonomik II",
    "VL_Monetaer": "Monetäre Ökonomik",
    "VL_Wachstum": "Wachstum und Nachhaltigkeit",
    "VL_Soziologie": "Wirtschaftssoziologie",

    "VL_Angewandte": "Angewandte Ökonomik",
    "VL_Makro2": "Makroökonomik II",
    "VL_International": "International Economics",
    "VL_SoEco": "Sozial-Ökologische Systeme",
    "VL_WiPo": "Wirtschaftspolitik",
}

#%%

with open(".gitignore") as f:
    ignores = f.read().splitlines()

ignores.append([
    "SUMMARY.md",
    "TOC.py",
    "README.md",
    "images",
    "LICENSE.md",
    ])

#%%
# get all files in the directory and subdirectories with type {dirname : filenames}

result_list = ["- [Startseite](README.md)","", "---"] # first two lines of the SUMMARY.md
count_files = 0
count_dirs = 0

for semester, desc in semesters.items():

    # add the semester as a headline
    
    result_list.append(f"[{desc}]({semester}/README.md)") 
    result_list.append("")
    result_list.append(f"")

    for dir in os.listdir(semester):

        if dir in dir_names.keys():

            # add the directory name as a headline
            result_list.append(f"- {dir_names[dir]}") 
            count_dirs += 1 # count the directories

            for file in sorted(os.listdir(f"{semester}/{dir}")):
                if file == "README.md":

                    # add the README.md as an overview
                    result_list.append(f"    - [Übersicht]({semester}/{dir}/{file})")
                    count_files += 1 # count the files 
                    continue

                if file not in ignores:
                    if file[-3:] == ".md": # only add markdown files, not directories
                        filename = file[11:-3]
                        filename = filename.replace("_", " ")
                        filename = filename.replace("-", " ")

                        # add the file to the list
                        result_list.append(f"    - [{filename}]({semester}/{dir}/{file})")
                        count_files += 1 # count the files

    # add a line break after each semester  
    result_list.append("")  
    result_list.append("---")
    result_list.append("")                  


# add the number of files and directories to the end of the SUMMARY.md
result_list.append(f"**{count_files}** Notizen in **{count_dirs}** Modulen")

with open("INDEX.md", "w") as f:
    f.writelines(line + '\n' for line in result_list)
    print("INDEX.md updated")

# %%
 