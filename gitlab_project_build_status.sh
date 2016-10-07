#!/bin/bash

# <bitbar.title>GitLab project build status</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>youpy</bitbar.author>
# <bitbar.author.github>youpy</bitbar.author.github>
# <bitbar.desc>Showing build status for your gitlab project in menu bar</bitbar.desc>
# <bitbar.dependencies>bash, jq, curl</bitbar.dependencies>

export PATH='/usr/local/bin:/usr/bin:$PATH'

gitlab_token="<gitlab_token>"
project_id="<project_id>"
api_endpoint="<api_endpoint>"

status=$(curl --header "PRIVATE-TOKEN: ${gitlab_token}" "${api_endpoint}/api/v3/projects/${project_id}/builds" 2>/dev/null | jq -r '.[0] | .status')
project_name=$(curl --header "PRIVATE-TOKEN: ${gitlab_token}" "${api_endpoint}/api/v3/projects/${project_id}" 2>/dev/null | jq -r '.path_with_namespace')

if [ $status = "success" ] ; then
    image="|image=iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAMAAAAolt3jAAAAsVBMVEUAAABVqlUrqlU2rl4xqmEurmg1qmAusmQ1rWIzr2YwrGcusWIyrmQxrmIyrmQwrmMysGQwsGMwrmMxrmUxrmMwr2QxsGUxr2Qxr2MxrmMysGQyrmUxr2Qxr2Myr2Mwr2Qyr2Uxr2Qxr2Qxr2QxrmQxr2Qwr2Mxr2Qxr2Qyr2QxrmQxsGQxr2Qxr2Qxr2Qxr2Qxr2Uwr2Qxr2Qxr2Qxr2Qxr2Qxr2Qxr2Qxr2Qxr2T///+Sb64cAAAAOXRSTlMAAwYTFRYYISIjJScpL1JVV1pfaH5/gYKDiIqLjI2Qmbm7vL/BwsPJys7R19zp6u/x8vP09fj6/f6DGjkXAAAAAWJLR0Q6TgnE+gAAAI5JREFUCNddj9sWgVAARHcpEcrtCJGkUhFKl9P//5iH8+ZxrzVrZg+AKbKyzLYGAKy+7TUIorZeArgytgCmqXTA+Nx0ldKT9wivmyjSsDtBESra3TWinNqH9YL9cIBTRe2jPV+X4QicK4oQxo/BA4hyVWVtAOxO/A/hyngGME+loyT7OAiSXkmCKbKmURd+kx0Ny5cY2lcAAAAASUVORK5CYII="
elif [ $status = "failed" ] ; then
    image="|image=iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAMAAAAolt3jAAAAnFBMVEUAAADVK1XfIGDXKFHOJFXRI1HRJ1XSJlPTJFDPKVPRJ1XTJVHTKFHSJ1HTKVLRKVHRKFPSKFLSKFPTKFLRKFLSKFHSJ1LSKFHSJ1PRKFPRKFLSKFHTKVHSKFHSKFLSJ1HSKFHSKFLSJ1HTKVLSKFLSKFLSKFLSKFLSJ1LSKFHSKFLSKFLSKFLSKFLSKFLSKFLSKFLSKFLSKFL////ikUDpAAAAMnRSTlMABggTFRYhIiMlJylSVVdYWVp+f4CBgoeIi4yNkLm7vL/BwsPKztHp7/Hy8/T1+Pr9/rNKRNoAAAABYktHRDM31XxeAAAAh0lEQVQI112PSRKCMAAEGwRXNo0CahDZFWRJ/v84D7lxnKqp6R4AV9RdV18cADj/ppeU+TQEAL4qtgD7SnngfN+WaVnlZ0M877AjiGwOs6DNINJJqkPIG4Y7EGt9Ax69iVetBfDsaTMIdZLqAPJmPbUC4aviCHCqlGckl0LKcjGS4Ip6HM2FP1X5DRf8oHgWAAAAAElFTkSuQmCC"
else
    image="|image=iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAMAAAAolt3jAAAAt1BMVEUAAAArqtUnndgwn98oodcxntsuotwsntwuotgtntosoNsrnNUwn9Yundgsotovndksn9ctn9gsntktn9ctoNksn9ktn9guoNguntktn9csn9gtoNgtoNgsn9gtntcuoNktn9gtoNctn9gtn9gtn9ctn9gsoNgtn9gtntctn9gtn9gtn9gsoNgtn9gtn9gtn9gtn9gtn9gtn9gtoNgtn9gtn9gtn9gtn9gtn9gtn9gtn9gtn9j///9KXDT7AAAAO3RSTlMABg0QExUWHSEiIyQlJyk8UlVXWn5/gouMjZCeq6yus7m7vL/BwsPKztHe6evt7u/w8fLz9PX2+Pr9/ghIMWYAAAABYktHRDynamHPAAAAk0lEQVQI1zWP5xKCQAyEFxWxYsVyFhRBVLAciJR7//eS5Ib8yXyTnc0uAHSdMIrCpQmexTc/C+Hl6ZxoVvk92oNrNQVMeTFqiI9DI3h3sCr6dFPqZY0KB/cTNKo9vBvSdYMfbBKNrV2NEtuExZOHasS1VTsmerIVPbLdnzxY/IhijMnM5hgUsvSFCEodkitkma7wB1tEEqZfixDcAAAAAElFTkSuQmCC"
fi

echo $project_name $image
