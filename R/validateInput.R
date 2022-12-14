validateInput <-
    function(dataset, content.field, content.vec, google.api.key, microsoft.api.key,
             source.lang, target.lang, microsoft.token){
        
        if((is.null(google.api.key) & (is.null(microsoft.api.key)))
           |
           (!is.null(google.api.key) & !is.null(microsoft.api.key)))
            {            
                stop('You must select either the Google or the Microsoft Translator. To select the Google Translator, pass a valid Google Translate api key to api.key. To select the Microsoft Translator, pass a valid Microsoft client id and client secret number to client.id and client.secret. You must select either Microsoft or Google, not both.')
            }
    
        if(is.null(google.api.key)){
            translator <- 'Microsoft'
        } else{translator <- 'Google'}
        
        if((is.null(dataset) | is.null(content.field)) & is.null(content.vec)){
            stop("You must either provide both a dataset and the content field or a single vector of content.")
        }

        languages <- languageCodes()
       
        if(translator == 'Google'){
            if(!is.null(source.lang)){
                if(!(source.lang %in% unname(unlist(languages['Google'])))){
                    msg <- paste("The source.lang '", source.lang, "' is not a valid Google language code. To see a list of Google language codes, use getGoogleLanguages().", sep = '')
                    stop(msg)
                }
            }
            if(!(target.lang %in% unname(unlist(languages['Google'])))){
                msg <- paste("The target.lang '", target.lang, "' is not a valid Google language code. To see a list of Google language codes, use getGoogleLanguages().", sep = '')
                stop(msg)
            }
        }    
        if(translator == 'Microsoft'){
             if(!is.null(source.lang)){
                if(!(source.lang %in% unname(unlist(languages['Microsoft'])))){
                    msg <- paste("The source.lang '", source.lang, "' is not a valid Microsoft language code. To see a list of Microsoft language codes, use getMicrosoftLanguages().", sep = '')
                    stop(msg)
                }
            }
            if(!(target.lang %in% unname(unlist(languages['Microsoft'])))){
                msg <- paste("The target.lang '", target.lang, "' is not a valid Microsoft language code. To see a list of Microsoft language codes, use getMicrosoftLanguages().", sep = '')
                stop(msg)
            }
        }
        if(!(is.null(dataset))){
            if(!(is.data.frame(dataset))){stop("dataset must be a data.frame.")}
        }
        if(!(is.null(content.field))){
            if(!(is.character(content.field))){stop("content.field must be a character.")}
        }
        if(!(is.null(content.field))){
            if(!(is.character(dataset[[content.field]]))){stop("The column containing the content must be a character vector.")}
        }
        if(!(is.null(content.vec))){
            if(!(is.character(content.vec))){stop("content.vec must be a character vector.")}
        }
        if(!(microsoft.token=="TRUE" | microsoft.token == "FALSE")){stop("microsoft.token must be a boolean value.")}
        
        return(translator)
    }
