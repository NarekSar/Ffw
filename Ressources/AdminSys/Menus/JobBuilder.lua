local newJobs = {
    onMenu = false,
    onRecap = false,
    typeIndex = 1,
    gradeCounter = 1,
    grades = {},
}

local jB_main = RageUI.CreateMenu("Job Builder", "Création d'entreprise")
jB_main.Closed = function()
    newJobs = {
        onMenu = false,
        onRecap = false,
        typeIndex = 1,
        gradeCounter = 1,
        grades = {},
    }
end
local jB_grade = RageUI.CreateSubMenu(jB_main, "Job Builder", "Création d'entreprise")
local jB_task = RageUI.CreateSubMenu(jB_grade, "Job Builder", "Création d'entreprise")

function openJb()
    newJobs.onMenu = true
    RageUI.Visible(jB_main, true)
    
    while newJobs.onMenu do
        Wait(0)

        RageUI.IsVisible(jB_main, function()
            if not newJobs.onRecap then
                RageUI.Button("Nom de l'entreprise", "Définie le nom de la futur entreprise.", {}, true, {
                    onSelected = function(Index, Items)
                        local newLabel = Keys.input(30, "30 caractères maximum !")
                        if newLabel ~= nil then
                            newJobs.label = newLabel
                        else
                            myPlayer:notify("Veuillez entré un nom d'entreprise.")
                        end
                    end,
                })
            end
            if newJobs.label then
                RageUI.Separator(string.format("Nom : %s", newJobs.label))
                if not newJobs.onRecap then
                    RageUI.List("Type de l'entreprise", {"Intéraction", "Récolte"}, newJobs.typeIndex, "Définie le type d'entreprise créer, appuyer sur ENTRE pour valider votre choix.", {}, true, {
                        onListChange = function(Index, Items)
                            newJobs.typeIndex = Index
                        end,
                        onSelected = function(Index, Items)
                            newJobs.type = Items
                        end,
                    })
                end
                if newJobs.type then
                    RageUI.Separator(string.format("Type d'entreprise : %s", newJobs.type))
                    RageUI.Separator(" ")
                    RageUI.Separator("Voulez vous continuer la création ??")
                    RageUI.Button("Valider", "Valider l'identité de l'entreprise, et passer aux détails.", {}, true, {
                        onSelected = function(Index, Items)
                            newJobs.onRecap = false
                            newJobs.typeIndex = 1
                        end,
                    }, jB_grade)
                    RageUI.Button("Annuler", "Annuler l'identité de l'entreprise, et revenez en arrière.", {}, true, {
                        onSelected = function(Index, Items)
                            newJobs = {
                                onRecap = false,
                                typeIndex = 1,
                            }
                        end,
                    })
                end
            end
        end)

        RageUI.IsVisible(jB_grade, function()
            RageUI.Separator(string.format("Grades : %s", newJobs.gradeCounter))
            RageUI.List("Nombre de grades", {1, 2, 3, 4, 5}, newJobs.gradeCounter, nil, {}, true, {
                onListChange = function(Index, Items)
                    newJobs.gradeCounter = Index
                end,
            })
            for i = 1, newJobs.gradeCounter do
                if not newJobs.grades[i] then
                    newJobs.grades[i] = {
                        int = i,
                    }
                end
                RageUI.Button(string.format("%s# : %s", newJobs.grades[i].int, (newJobs.grades[i].label or "")), nil, {}, true, {
                    onSelected = function(Index, Items)
                        local newLabel = Keys.input(30, "30 caractères maximum !")
                        if newLabel ~= nil then
                            newJobs.grades[i].label = newLabel
                        else
                            myPlayer:notify("Veuillez entré un nom de grade.")
                        end
                    end,
                })
                if newJobs.grades[i].label then
                    RageUI.Button(string.format("Salaire %s : ~g~%s $", newJobs.grades[i].label, (newJobs.grades[i].salary or "")), nil, {}, true, {
                        onSelected = function(Index, Items)
                            local newSalary = Keys.input(3, "3 caractères maximum !")
                            if tonumber(newSalary) ~= nil then
                                newJobs.grades[i].salary = tonumber(newSalary)
                            else
                                myPlayer:notify("Veuillez entré un salaire.")
                            end
                        end,
                    })
                end
            end
            RageUI.Separator(" ")
            RageUI.Button("Valider les grades", nil, {}, true, {
                onSelected = function(Index, Items)
                    for i = 1, #newJobs.grades do
                        if not newJobs.grades[i].salary then
                            newJobs.onRecap = false
                            if newJobs.grades[i].label then
                                myPlayer:notify(string.format("Pas de salaire définie pour : %s", newJobs.grades[i].label))
                            else
                                myPlayer:notify(string.format("Pas de label définie pour : %s#", i))
                            end
                        else
                            newJobs.onRecap = true
                        end
                    end
                    if newJobs.onRecap then
                        RageUI.Visible(jB_task, true)
                        newJobs.onRecap = false
                    end
                end,
            })
        end)

        RageUI.IsVisible(jB_task, function()
            if newJobs.type == "Intéraction" then
                -- To do : 
                -- Chose pos
                -- Choose car
            elseif newJobs.type == "Récolte" then
                -- To do : 
                -- Create item 1 / 2
                -- Chose pos
                -- Choose car
            end
            if newJobs.onRecap then

            end
        end)
    end
end