# Configuration file for the Sphinx documentation builder.
#
# Full list of options can be found in the Sphinx documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

import os
from typing import Any, Dict


# -- Project information -----------------------------------------------------
#

project = "VWL"
copyright = "marten w."
author = "marten w."

# -- General configuration ---------------------------------------------------
#

extensions = [
    # Sphinx's own extensions
    "sphinx.ext.autodoc",
    "sphinx.ext.extlinks",
    "sphinx.ext.mathjax",
    "sphinx.ext.todo",
    "sphinx.ext.viewcode",
    "sphinx.ext.githubpages",
    # Our custom extension, only meant for Furo's own documentation.
    "furo.sphinxext",
    # External stuff
    "myst_parser",
    "sphinx_copybutton",
    "sphinx_design",
    "sphinx_inline_tabs",
    "sphinxcontrib.mermaid",
    "sphinx_external_toc",
    'sphinx_sitemap',
    "sphinx_reredirects",
    'notfound.extension',
]

# -- Options for extlinks ----------------------------------------------------
#

extlinks = {
    "pypi": ("https://pypi.org/project/%s/", "%s"),
}


# -- Options for TODOs -------------------------------------------------------
#

todo_include_todos = True

# -- Options for Markdown files ----------------------------------------------
#

myst_enable_extensions = [
    "colon_fence",
    "deflist",
    "dollarmath",
]
myst_heading_anchors = 5
myst_fence_as_directive = ["mermaid"]

suppress_warnings = ["myst.header", "myst.xref_missing"]

# -- Options for HTML output -------------------------------------------------
#

html_theme = "furo"
html_title = "Marten's Notizen"
html_baseurl = 'https://vwl.martenw.com/#/'
html_file_suffix = ""
html_extra_path = ["robots.txt"]
html_static_path = ["_static"]
language = "de"


html_theme_options: Dict[str, Any] = {
    "light_css_variables": {
        "color-brand-primary": "#336699",
        "color-brand-content": "#336699",
    },
}
# -- Options for TOC output -------------------------------------------------
# with the external TOC extension

external_toc_path = "_toc.yml"  # optional, default: _toc.yml

# -- Options for Redirects -------------------------------------------------
# with the redirects extension NOTWORKING

# redirects = {
#     "/#/vwl1/VL_Buchfuehrung/2021-10-00-Buchungsaetze": "/vwl1/VL_Buchfuehrung/2021-10-00-Buchungssaetze",
#     "/#/vwl1/VL_BWL/2021-10-00-Zusammenfassung": "/vwl1/VL_BWL/2021-10-00-Zusammenfassung",
#     "/#/vwl1/VL_Statistik1/2021-10-00-Zusammenfassung": "/vwl1/VL_Statistik1/2021-10-00-Zusammenfassung",
#     "/#/vwl1/VL_VWL/2021-10-00-Zusammenfassung": "/vwl1/VL_VWL/2021-10-00-Zusammenfassung",
#     "/#/vwl1/VL_Wirtschaftsinformatik/2021-10-00-Zusammenfassung": "/vwl1/VL_Wirtschaftsinformatik/2021-10-00-Zusammenfassung",
#     #
#     "/#/vwl2/VL_Statistik2/2022-04-00-Zusammenfassung": "/vwl2/VL_Statistik2/2022-04-00-Zusammenfassung",
#     "/#/vwl2/VL_Mikro/2022-04-00-Formelsammlung": "/vwl2/VL_Mikro/2022-04-00-Formelsammlung",
#     "/#/vwl2/VL_Recht-WiWi/2022-04-00-Zusammenfassung": "/vwl2/VL_Recht-WiWi/2022-04-00-Zusammenfassung",
#     #
#     "/#/vwl3/VL_Monetaer/2022-10-00-Zusammenfassung": "/vwl3/VL_Monetaer/2022-10-00-Zusammenfassung",
#     "/#/vwl3/VL_Ethik/2022-10-00-Zusammenfassung": "/vwl3/VL_Ethik/2022-10-00-Zusammenfassung",
#     #
#     "/#/vwl4/VL_Angewandte/2023-04-00-Lesenotizen": "/vwl4/VL_Angewandte/2023-04-00-Lesenotizen",
#     "/#/vwl4/VL_International/2023-04-00-Zusammenfassung": "/vwl4/VL_International/2023-04-00-Zusammenfassung",
#     "/#/vwl4/VL_Makro2/2023-04-00-Zusammenfassung": "/vwl4/VL_Makro2/2023-04-00-Zusammenfassung",
#     "#/vwl4/VL_WiPo/2023-04-00-Lesenotizen": "/vwl4/VL_WiPo/2023-04-00-Lesenotizen",
# }

