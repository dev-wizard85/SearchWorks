module Constants
 UNKNOWN_LOCS = ["ASK@EASIA", "ASK@GSB", "ASK@LANE", "CHECKSHELF", "SEE-OTHER", "STACKS-BW"]
 PAGE_LOCS = ["BIO-TEMP", "EALSAL-CHN", "EALSAL-JPN", "EALSAL-KOR", "L-PAGE-EA", "MATH-TEMP", "MEDIA-30", "MEDIAX-30", "MSS-30", "PAGE-BU", "PAGE-LP", "PAGE-MP", "PAGE-IRON", "SAL-ARABIC", "SAL-FOLIO", "SAL-LOAN", "SAL-MUSIC", "SAL-SERG", "SAL-TEMP", "SALTURKISH", "STACKS-30"]
 RELATOR_TERMS = {"acp" => "Art copyist",
   "act" => "Actor",
   "adp" => "Adapter",
   "aft" => "Author of afterword, colophon, etc.",
   "anl" => "Analyst",
   "anm" => "Animator",
   "ann" => "Annotator",
   "ant" => "Bibliographic antecedent",
   "app" => "Applicant",
   "aqt" => "Author in quotations or text abstracts",
   "arc" => "Architect",
   "ard" => "Artistic director ",
   "arr" => "Arranger",
   "art" => "Artist",
   "asg" => "Assignee",
   "asn" => "Associated name",
   "att" => "Attributed name",
   "auc" => "Auctioneer",
   "aud" => "Author of dialog",
   "aui" => "Author of introduction",
   "aus" => "Author of screenplay",
   "aut" => "Author",
   "bdd" => "Binding designer",
   "bjd" => "Bookjacket designer",
   "bkd" => "Book designer",
   "bkp" => "Book producer",
   "bnd" => "Binder",
   "bpd" => "Bookplate designer",
   "bsl" => "Bookseller",
   "ccp" => "Conceptor",
   "chr" => "Choreographer",
   "clb" => "Collaborator",
   "cli" => "Client",
   "cll" => "Calligrapher",
   "clt" => "Collotyper",
   "cmm" => "Commentator",
   "cmp" => "Composer",
   "cmt" => "Compositor",
   "cng" => "Cinematographer",
   "cnd" => "Conductor",
   "cns" => "Censor",
   "coe" => "Contestant -appellee",
   "col" => "Collector",
   "com" => "Compiler",
   "cos" => "Contestant",
   "cot" => "Contestant -appellant",
   "cov" => "Cover designer",
   "cpc" => "Copyright claimant",
   "cpe" => "Complainant-appellee",
   "cph" => "Copyright holder",
   "cpl" => "Complainant",
   "cpt" => "Complainant-appellant",
   "cre" => "Creator",
   "crp" => "Correspondent",
   "crr" => "Corrector",
   "csl" => "Consultant",
   "csp" => "Consultant to a project",
   "cst" => "Costume designer",
   "ctb" => "Contributor",
   "cte" => "Contestee-appellee",
   "ctg" => "Cartographer",
   "ctr" => "Contractor",
   "cts" => "Contestee",
   "ctt" => "Contestee-appellant",
   "cur" => "Curator",
   "cwt" => "Commentator for written text",
   "dfd" => "Defendant",
   "dfe" => "Defendant-appellee",
   "dft" => "Defendant-appellant",
   "dgg" => "Degree grantor",
   "dis" => "Dissertant",
   "dln" => "Delineator",
   "dnc" => "Dancer",
   "dnr" => "Donor",
   "dpc" => "Depicted",
   "dpt" => "Depositor",
   "drm" => "Draftsman",
   "drt" => "Director",
   "dsr" => "Designer",
   "dst" => "Distributor",
   "dtc" => "Data contributor ",
   "dte" => "Dedicatee",
   "dtm" => "Data manager ",
   "dto" => "Dedicator",
   "dub" => "Dubious author",
   "edt" => "Editor",
   "egr" => "Engraver",
   "elg" => "Electrician ",
   "elt" => "Electrotyper",
   "eng" => "Engineer",
   "etr" => "Etcher",
   "exp" => "Expert",
   "fac" => "Facsimilist",
   "fld" => "Field director ",
   "flm" => "Film editor",
   "fmo" => "Former owner",
   "fpy" => "First party",
   "fnd" => "Funder",
   "frg" => "Forger",
   "gis" => "Geographic information specialist ",
   "grt" => "Graphic technician",
   "hnr" => "Honoree",
   "hst" => "Host",
   "ill" => "Illustrator",
   "ilu" => "Illuminator",
   "ins" => "Inscriber",
   "inv" => "Inventor",
   "itr" => "Instrumentalist",
   "ive" => "Interviewee",
   "ivr" => "Interviewer",
   "lbr" => "Laboratory ",
   "lbt" => "Librettist",
   "ldr" => "Laboratory director ",
   "led" => "Lead",
   "lee" => "Libelee-appellee",
   "lel" => "Libelee",
   "len" => "Lender",
   "let" => "Libelee-appellant",
   "lgd" => "Lighting designer",
   "lie" => "Libelant-appellee",
   "lil" => "Libelant",
   "lit" => "Libelant-appellant",
   "lsa" => "Landscape architect",
   "lse" => "Licensee",
   "lso" => "Licensor",
   "ltg" => "Lithographer",
   "lyr" => "Lyricist",
   "mcp" => "Music copyist",
   "mfr" => "Manufacturer",
   "mdc" => "Metadata contact",
   "mod" => "Moderator",
   "mon" => "Monitor",
   "mrk" => "Markup editor",
   "msd" => "Musical director",
   "mte" => "Metal-engraver",
   "mus" => "Musician",
   "nrt" => "Narrator",
   "opn" => "Opponent",
   "org" => "Originator",
   "orm" => "Organizer of meeting",
   "oth" => "Other",
   "own" => "Owner",
   "pat" => "Patron",
   "pbd" => "Publishing director",
   "pbl" => "Publisher",
   "pdr" => "Project director",
   "pfr" => "Proofreader",
   "pht" => "Photographer",
   "plt" => "Platemaker",
   "pma" => "Permitting agency",
   "pmn" => "Production manager",
   "pop" => "Printer of plates",
   "ppm" => "Papermaker",
   "ppt" => "Puppeteer",
   "prc" => "Process contact",
   "prd" => "Production personnel",
   "prf" => "Performer",
   "prg" => "Programmer",
   "prm" => "Printmaker",
   "pro" => "Producer",
   "prt" => "Printer",
   "pta" => "Patent applicant",
   "pte" => "Plaintiff -appellee",
   "ptf" => "Plaintiff",
   "pth" => "Patent holder",
   "ptt" => "Plaintiff-appellant",
   "rbr" => "Rubricator",
   "rce" => "Recording engineer",
   "rcp" => "Recipient",
   "red" => "Redactor",
   "ren" => "Renderer",
   "res" => "Researcher",
   "rev" => "Reviewer",
   "rps" => "Repository",
   "rpt" => "Reporter",
   "rpy" => "Responsible party",
   "rse" => "Respondent-appellee",
   "rsg" => "Restager",
   "rsp" => "Respondent",
   "rst" => "Respondent-appellant",
   "rth" => "Research team head",
   "rtm" => "Research team member",
   "sad" => "Scientific advisor",
   "sce" => "Scenarist",
   "scl" => "Sculptor",
   "scr" => "Scribe",
   "sds" => "Sound designer",
   "sec" => "Secretary",
   "sgn" => "Signer",
   "sht" => "Supporting host",
   "sng" => "Singer",
   "spk" => "Speaker",
   "spn" => "Sponsor",
   "spy" => "Second party",
   "srv" => "Surveyor",
   "std" => "Set designer",
   "stl" => "Storyteller",
   "stm" => "Stage manager",
   "stn" => "Standards body",
   "str" => "Stereotyper",
   "tcd" => "Technical director",
   "tch" => "Teacher",
   "ths" => "Thesis advisor",
   "trc" => "Transcriber",
   "trl" => "Translator",
   "tyd" => "Type designer",
   "tyg" => "Typographer",
   "vdg" => "Videographer",
   "voc" => "Vocalist",
   "wam" => "Writer of accompanying material",
   "wdc" => "Woodcutter",
   "wde" => "Wood -engraver",
   "wit" => "Witness"}
 LOCS = {"13TH-FLOOR" => "13th floor",
   "15TH-FLOOR" => "15th floor",
   "1ST-FLOOR" => "1st floor",
   "2ND-FLOOR" => "2nd floor",
   "2NDFLR-REF" => "2nd floor (non-circulating)",
   "3RD-FLOOR" => "3rd floor",
   "3RDFLR-REF" => "3rd floor (non-circulating)",
   "ACAD-DATA" => "Social Sciences Data Services (SSDS)",
   "ARABIC" => "Arabic",
   "ARTLCKL" => "Locked Stacks, Large",
   "ARTLCKL-R" => "Locked Stacks, Large (restricted access)",
   "ARTLCKM" => "Locked Stacks, Medium",
   "ARTLCKM-R" => "Locked Stacks, Medium (restricted access)",
   "ARTLCKO" => "Locked Stacks, Oversize",
   "ARTLCKO-R" => "Locked Stacks, Oversize (restricted access)",
   "ARTLCKS" => "Locked Stacks, Small",
   "ARTLCKS-R" => "Locked Stacks, Small (restricted access)",
   "ART-LOAN" => "Art & Architecture Library circulation desk",
   "ART-RESV" => "On reserve at Art & Architecture Library Library",
   "ART-AT-ENG" => "Currently available at Engineering Library (Terman)",
   "ARTVAULT" => "Art Vault",
   "ASK@EASIA" => "Check East Asia Library for holdings",
   "ASK@GSB" => "Check Business Library catalog for status",
   "ASK@LANE" => "Check Medical Library (Lane) catalog for status",
   "ASSMD-LOST" => "Assumed lost",
   "ATLASES" => "Atlas Section",
   "AT-REPAIR" => "Out for repair",
   "AVAIL_SOON" => "Not available right now",
   "B&F-HOLD" => "At bindery",
   "BARCHAS" => "Barchas Collection (non-circulating)",
   "BASEMENT" => "Basement",
   "BASEMNT" => "Basement",
   "BENDER" => "Bender Room (non-circulating)",
   "BIB-INDEX" => "Bibliographies & Indexes section",
   "BILLED-OD" => "Overdue",
   "BINDERY" => "At bindery",
   "BIO-LOAN" => "Biology Library (Falconer) circulation desk",
   "BIO-RESV" => "On reserve at Biology Library (Falconer)",
   "BIO-TEMP" => "See loan desk for access",
   "BUS-ARCH" => "Archives (ask at i-Desk)",
   "BUS-LOAN" => "i-Desk",
   "BUS-CMC" => "Career Corner",
   "BUS-COMPF" => "Computer Files (ask at i-Desk)",
   "PAGE-IRON" => "Offsite",
   "BUSDISPLAY" => "Display shelves",
   "BUS-PER" => "Periodicals",
   "BUS-POP" => "Popular Business Books",
   "BUS-LOCKED" => "Locked Stacks (ask at i-Desk)",
   "BUS-MAKENA" => "Makena Capital Traders Pit",
   "BUS-RESV" => "On reserve at Business Library",
   "BUS-STACKS" => "Stacks",
   "BUS-TEMP" => "Ask at i-Desk",
   "BOX-COLL" => "Box Collection",
   "BRAN-RESV" => "On reserve at Earth Sciences Library (Branner)",
   "BRIT-DOCS" => "British Government Documents",
   "CALIF-DOCS" => "California State Documents",
   "CCRMA" => "Center for Computer Research in Music and Acoustics",
   "CDL-2NDFL" => "Curriculum Development Lab",
   "CDP" => "Collection Development Program",
   "CDP-CHI" => "CDP-CHI",
   "CDP-GER" => "Collection Development Program: Germanic Studies",
   "CDP-JUDA" => "Collection Development Program: Judaica",
   "CDP-LAT" => "Collection Development Program: Latin America",
   "CDP-ROM" => "Collection Development Program: Romance Languages",
   "CDP-SLAV" => "Collection Development Program: Slavic Studies",
   #"CHECKEDOUT" => "Checked out - Due <date>",
   "CHECKSHELF" => "Check shelf",
   "CHE-LOAN" => "Chemistry & ChemEng Library (Swain) circulation desk",
   "CHEM-RESV" => "On reserve at Chemistry & ChemEng Library (Swain)",
   "CHINESE" => "Chinese Collection",
   "CHKD-OUT-D" => "Ask at circulation desk",
   "COLL-WORKS" => "Storage Area: Collected Works Section",
   "COMPACT" => "Compact shelving",
   "COURSE-RES" => "Course reserves",
   "COURSE-VID" => "Course videos",
   "CPM-HOLDS" => "At bindery",
   "CROTHERS" => "Crothers Collection",
   "CURRENTPER" => "Current Periodicals",
   "CURRICULUM" => "Curriculum Collection",
   "CURRSTOR" => "Ask at circulation desk",
   "DOMESTIC" => "Domestic",
   "EALSAL-CHN" => "Chinese materials in SAL1&2",
   "EALSAL-JPN" => "Japanese materials in SAL1&2",
   "EALSAL-KOR" => "Korean materials in SAL1&2",
   "EAL-SETS" => "East Asia Big Sets",
   "EAL-STKS-C" => "Chinese Collection",
   "EAL-STKS-J" => "Japanese Collection",
   "EAL-STKS-K" => "Korean Collection",
   "EAR-LOAN" => "Earth Sciences Library (Branner) circulation desk",
   "EARTH-RESV" => "On reserve at Earth Sciences Library (Branner)",
   "EAS-LOAN" => "East Asia Library circulation desk",
   "EAS-RESV" => "East Asia Library reserves",
   "EDI" => "In process",
   "EDU-LOAN" => "Education Library (Cubberley) circulation desk",
   "EDU-RESV" => "On reserve at Education Library (Cubberley)",
   "ENDPROCESS" => "Not available right now",
   "ENGDISPLAY" => "Engineering Library (Terman) display (latest 3 issues only)",
   "ENG-LOAN" => "Engineering Library (Terman) circulation desk",
   "ENG-RESV" => "On reserve at Engineering Library (Terman)",
   "EQUIPMENT" =>"Equipment: ask at desk",
   "EXPEDITION" => "Expedition: Locked Stacks",
   "FACULTY" => "Faculty",
   "FED-DOCS" => "US Federal Documents",
   "FELTON" => "Felton Collection (non-circulating)",
   "FELTON-30" => "Felton Collection (non-circulating)",
   "FELT-STOR" => "Felton storage (non-circulating)",
   "FOLIO" => "Folio",
   "FOLIO-3RD" => "Folios on the 3rd floor",
   "FOLIO-BAS" => "Folios in the basement",
   "FOLIO-CHN" => "Chinese Folios",
   "FOLIO-FLAT" => "Flat Folio",
   "FOLIO-JPN" => "Japanese Folios",
   "FOLIO-KOR" => "Korean Folios",
   "FOREIGN" => "Foreign",
   "FORN-DOCS" => "Foreign Government Documents",
   "FRECOT" => "Frecot Collection (non-circulating)",
   "GADGETBAR" => "Gadget Bar",
   "GOLDSTAR" => "Ask at circulation desk",
   "GREEN-RESV" => "Green Library reserves",
   "GRE-LOAN" => "Green Library circulation desk",
   "GSB-RESV" => "Business Library reserves",
   "GUNST" => "Gunst Collection (non-circulating)",
   "GUNST-30" => "Gunst Collection (non-circulating)",
   "GUNST-STOR" => "Gunst Storage (non-circulating)",
   "HAS-ATLAS" => "HAS Atlas Collection (Lane Room) (non-circulating)",
   "HAS-CA" => "HAS California History (Lane Room) (non-circulating)",
   "HAS-DIGIT" => "HAS-DIGIT (Lane Room) (non-circulating)",
   "HAS-FIC" => "HAS Fiction (Lane Room)",
   "HAS-FOLIO" => "HAS Folio (Lane Room) (non-circulating)",
   "HAS-JOURN" => "HAS Journal Collection (Lane Room) (non-circulating)",
   "HAS-LIT" => "HAS Literary Criticism (Lane Room) (non-circulating)",
   "HAS-NEWBK" => "HAS New Books (Lane Room)",
   "HASRC" => "HASRC (Lane Room) (non-circulating)",
   "HAS-RR" => "HAS Ready Reference (Lane Room) (non-circulating)",
   "HAS-SU" => "HAS Stanford History (Lane Room) (non-circulating)",
   "HMS-PAGE" => "In transit",
   "HMS-RETURN" => "In transit",
   "HOLDS" => "Ask at circulation desk",
   "HOO-LOAN" => "Marine Biology Library (Miller) circulation desk",
   "HOOV-RESV" => "Marine Biology Library (Miller) reserves desk",
   "HOP-LOAN" => "Marine Biology Library (Miller) circulation desk",
   "HOP-RESV" => "Marine Biology Library (Miller) reserves",
   "HVA-LOAN" => "Hoover Archives circulation desk",
   "HV-TRANS" => "In transit",
   "HY-PAGE-EA" => "Harvard-Yenching Collection",
   "IC" => "InfoCenter (non-circulating)",
   "IC-ATLAS" => "InfoCenter: atlas shelves (non-circulating)",
   "IC-CDROM" => "InfoCenter: CD-ROMS (non-circulating)",
   "IC-DESK" => "InfoCenter: desk (non-circulating)",
   "IC-DISPLAY" => "InfoCenter: display",
   "IC-EXHIBIT" => "InfoCenter: exhibit",
   "IC-NEWS" => "InfoCenter: newspapers (non-circulating)",
   "IC-RREF" => "InfoCenter: Ready Reference (non-circulating)",
   "IC-STATS" => "InfoCenter: statistics shelves (non-circulating)",
   "ILB-LOAN" => "Borrowed through ILB",
   "ILL" => "Interlibrary loan",
   "ILL-OFFICE" => "Interlibrary Services Department",
   "INDEXES" => "Indexes",
   "INPROCESS" => "In process",
   "INSHIPPING" => "In process",
   "INSTRUCTOR" => "Instructor's copy",
   "INTCOLLCAT" => "International college catalogs",
   "INTERNET"   => "Online resource",
   "INTL-DOCS" => "International Government Documents",
   "INTRANSIT" => "In transit",
   "JAPANESE" => "Japanese Collection",
   "KOREAN" => "Korean Collection",
   "LAC" => "Out for vendor cataloging",
   "LANE-RESV" => "On reserve at Medical Library (Lane)",
   "LANG-LAB" => "Language Lab",
   "LANG-RESV" => "Language Lab reserves",
   "LAW-ARCHIV" => "Law Library (Crown) Archives: ask at circulation desk",
   "LAW-BIND" => "At bindery",
   "LAW-LOAN" => "Law Library (Crown) circulation desk",
   "LAW-RESV" => "Law Library (Crown) reserves: ask at circulation desk",
   "LAW-REVIEW" => "Law Review",
   "LAW-SPEC" => "Law Collection (non-circulating)",
   "LCKBYTITL" => "Locked Stacks: ask at circulation desk",
   "LCK-STOR" => "Locked Stacks: ask at circulation desk",
   "LEWIS-COLL" => "Lewis Collection",
   "LOAN-DESK" => "Held at circulation desk",
   "LOCK-CHN" => "Locked Stacks: ask at circulation desk",
   "LOCKED-DIS" => "Locked Stacks: ask at circulation desk",
   "LOCKED-MAP" => "Locked Map Files: ask at circulation desk",
   "LOCKED-STK" => "Locked Stacks: ask at circulation desk",
   "LOCK-HOLDS" => "Locked Stacks: ask at circulation desk",
   "LOCK-JPN" => "Locked Stacks: ask at circulation desk",
   "LOCK-KOR" => "Locked Stacks: ask at circulation desk",
   "LOST-ASSUM" => "Assumed lost",
   "LOST-CLAIM" => "Lost",
   "LOST-PAID" => "Lost",
   "L-PAGE-EA" => "Locked Stacks",
   "MANNING" => "Manning Collection (non-circulating)",
   "MANUSCRIPT" => "Manuscript Collection",
   "MAP-CASES" => "Map cases",
   "MAP-FILE" => "Map files",
   "MAP-REF" => "Reference maps",
   "MAPS" => "Maps",
   "MAP-STOR" => "Map storage: ask at circulation desk",
   "MATH-ARCH" => "Ask at circulation desk",
   "MATH-RESV" => "On reserve at Math & Statistics Library",
   "MATH-TECH" => "Ask at circulation desk",
   "MATH-TEMP" => "See loan desk for access",
   "MAT-LOAN" => "Math & Statistics Library circulation desk",
   "MEDIA" => "Media",
   "MEDIA-30" => "Media",
   "MEDIA-MTXT" => "Media & Microtext Center (Lower level)",
   "MEDIA-RESV" => "Media & Microtext Center Reserves",
   "MEDIAX" => "Media Collection (Restricted access)",
   "MEDIAX-30" => "Media Collection",
   "MEDIEVALRM" => "Medieval Studies Room (non-circulating)",
   "MEMLIBMUS" => "Memorial Library of Music (non-circulating)",
   "MEYER-RESV" => "Reserves",
   "MEY-LOAN" => "Meyer Library 2nd floor Tech Desk",
   "MEZZANINE" => "Mezzanine shelving area",
   "MICROFICHE" => "Microfiche",
   "MICROFILM" => "Microfilm",
   "MICROTEXT" => "Microtext",
   "MINIATURE" => "Miniature",
   "MISSING" => "Missing",
   "MISS-INPRO" => "Missing",
   "MSS-10" => "Manuscript Collection",
   "MSS-20" => "Manuscript Collection",
   "MSS-30" => "Manuscript Collection",
   "MSSX" => "Manuscript Collection: restricted access",
   "MSSX-30" => "Manuscript Collection",
   "MUSIC-RESV" => "On reserve at Music Library",
   "MUS-LOAN" => "Music Library circulation desk",
   "MUS-NOCIRC" => "Music Library (non-circulating)",
   "MUS-TXTBK" => "Music class textbook",
   "ND-PAGE-EA" => "NDC Collection",
   "NEWBOOKS" => "New book shelf",
   "NEWSPAPERS" => "Newspapers",
   "NEWS-STKS" => "Newspaper stacks",
   "NEWTON" => "Newton Collection (non-circulating)",
   "ON-ORDER" => "On order",
   "OPEN-RES" => "Open reserves",
   "OVERSIZED" => "Oversized",
   "PAGE-AR" => "Use restricted to the Art Library or Special Collections",
   "PAGE-AS" => "Use restricted to Archive of Recorded Sound",
   "PAGE-BI" => "Use restricted to Biology Library (Falconer)",
   "PAGE-BU" => "Use restricted to Business Library",
   "PAGE-CH" => "Use restricted to Chemistry & ChemEng Library (Swain)",
   "PAGE-CL" => "Use restricted to Classics Library",
   "PAGE-EA" => "Use restricted to East Asia Library",
   "PAGE-ED" => "Use restricted to Education Library (Cubberley)",
   "PAGE-EN" => "Use restricted to Engineering Library (Terman)",
   "PAGE-ES" => "Use restricted to Earth Sciences Library (Branner)",
   "PAGE-GR" => "Use restricted to Green Library",
   "PAGE-HA" => "Use restricted to Hoover Archives",
   "PAGE-HP" => "Use restricted to the Marine Biology Library (Miller) or Green Library",
   "PAGE-HV" => "Use restricted to Hoover Library",
   "PAGE-ILL" => "Paged to Interlibrary Loan Department",
   "PAGE-JA" => "Paged to Business Library",
   "PAGE-LN" => "Paged to Medical Library (Lane)",
   "PAGE-LP" => "Paging restricted to Music Library or Green Media & Microtext Center",
   "PAGE-LW" => "Use restricted to Law Library (Crown)",
   "PAGE-MA" => "Use restricted to Math & Statistics Library",
   "PAGE-MD" => "Use restricted to Green Media & Microtext Center",
   "PAGE-MP" => "Paging restricted to Earth Sciences Library (Branner)",
   "PAGE-MU" => "Use restricted to Music Library",
   "PAGE-MY" => "Use restricted to Meyer Library",
   "PAGE-PH" => "Use restricted to Physics Library",
   "PAGE-RLCP" => "Paged for Research Library Cooperative Program",
   "PAGE-SP" => "Use restricted to Special Collections",
   "PAGE-TA" => "Use restricted to Philosophy Library (Tanner)",
   "PERM-RES" => "Permanent reserve",
   "PERSIAN" => "Persian",
   "PGDFROMSAL" => "Paged from SAL to campus library",
   "PHOTO-PERM" => "Ask at circulation desk",
   "PHY-LOAN" => "Physics Library circulation desk",
   "PHYS-RESV" => "On reserve at Physics Library ",
   "PHYSTEMP" => "Currently online only",
   "PUB-TECH" => "Not available right now",
   "RARE-BOOKS" => "Rare Books Collection (non-circulating)",
   "RARE-STOR" => "Rare Books storage (non-circulating)",
   "RAUB-COLL" => "Raubitschek Collection of Papyrology and Epigraphy",
   "RBC-30" => "Rare Books Collection",
   "RBCX" => "Rare Books Collection: Restricted access",
   "RBCX-30" => "Rare Books Collection",
   "READING-RM" => "Reading Room",
   "READY-REF" => "Ready Reference shelf",
   "RECORDINGS" => "Recordings",
   "REF-CHN" => "Reference (Chinese) (non-circulating)",
   "REF-DESK" => "Reference Desk (non-circulating)",
   "REFERENCE" => "Reference (non-circulating)",
   "REF-JPN" => "Reference (Japanese) (non-circulating)",
   "REF-KOR" => "Reference (Korean) (non-circulating)",
   "REF-SERIAL" => "Reference Serial (non-circulating)",
   "REPAIR" => "Sent for repair",
   "RESEARCH" => "Research",
   "SW-RESERVE-DESK" => "Request at circulation desk", #special internal code that SearchWorks uses for reserves.
   "SW-E-RESERVE-DESK" => "Online item on course reading list", #special internal code that SearchWorks uses for reserves.
   "RESERVES" => "Reserves",
   "RESV-DESKS" => "Reserves",
   "RET-REF" => "Retired Reference (non-circulating)",
   "R-FOLIO" => "Folio (Limited loan)",
   "R-FOLIO-FL" => "Flat folio (Limited loan)",
   "R-MINIATUR" => "Miniature (Limited loan)",
   "ROBINSON" => "Robinson Collection (non-circulating)",
   "ROB-STOR" => "Robinson Collection Storage (non-circulating)",
   "R-STACKS" => "Stacks (Limited loan)",
   "RUMSEY" => "Rumsey Collection (non-circulating)",
   "SAFETY" => "Safety Collection (non-circulating)",
   "SAL-ARABIC" => "Temporary shelving for Arabic materials",
   "SAL-FOLIO" => "Temporary shelving for Folio materials",
   "SAL-LOAN" => "SAL circulation desk",
   "SAL-MUSIC" => "Temporary shelving for Music materials",
   "SAL-PAGE" => "Temporary shelving",
   "SAL-RETURN" => "Returning to SAL",
   "SAL-SERG" => "Science and Engineering shelving at SAL",
   "SAL-TEMP" => "Temporary shelving",
   "SALTURKISH" => "Temporary shelving for Turkish materials",
   "SAMSON" => "Samson Collection",
   "SCBS" => "Bldg. 70, Stanford Center for Buddhist Studies (non-circulating)",
   "SCORES" => "Scores",
   "SEE-ARCHIV" => "Lent to Hoover Archives",
   "SEE-EASTA" => "Lent to East Asia Library",
   "SEE-LOAN" => "See circulation desk for access",
   "SEE-OTHER" => "See related record(s) to request item",
   "SERIALS" => "Serials",
   "SETS" => "Big Sets",
   "SHELBYSER" => "Serials",
   #"SHELBYSER" => "Serials - Shelved by series title",
   #"SHELBYTITL" => "Serials - Shelved by title",
   "SHELBYTITL" => "Serials",
   "SL3-LOAN" => "Ask at Green Library circulation desk",
   "SLN-LOAN" => "Ask at Green Library  circulation desk",
   "SOUTH-MEZZ" => "Stacks",
   "SPECDESK" => "Ask at Special Collections service desk",
   "SPEC-STOR" => "Special Collections storage",
   "SPE-LOAN" => "Ask at Special Collections service desk",
   "SSRC" => "Social Sciences Resource Center (non-circulating)",
   "SSRC-ANRPT" => "SSRC: Annual Reports (non-circulating)",
   "SSRC-ATLAS" => "SSRC: atlas shelves (non-circulating)",
   "SSRC-CLASS" => "SSRC: classic texts",
   "SSRC-CSLI" => "SSRC: Center for the Study of Language & Information",
   "SSRC-CURR" => "SSRC: Current Awareness (non-circulating)",
   "SSRC-DATA" => "Social Science Data and Software: Virtual Data Collection",
   "SSRC-DESK" => "Social Sciences Resource Center desk (non-circulating)",
   "SSRC-DOCS" => "SSRC: Government Documents (non-circulating)",
   "SSRC-FICHE" => "SSRC: Microfiche (non-circulating)",
   "SSRC-FILM" => "SSRC: Microfilm (non-circulating)",
   "SSRC-NEWBK" => "SSRC: new books shelf",
   "SSRC-NWDOC" => "SSRC: new documents shelf",
   "SSRC-SSDS" => "Social Science Data and Software: Velma Denning Room (non-circulating)",
   "STACKS" => "Stacks",
   "STACKS-1" => "Stacks 1",
   "STACKS-2" => "Stacks 2",
   "STACKS-3" => "Stacks 3",
   "STACKS-30" => "Stacks",
   "STACKS-BW" => "Bound with another item",
   "STAFF" => "Ask at circulation desk",
   "STK-NOCIRC" => "Stacks, non-circulating item",
   "STKS1-NEW" => "New book shelf",
   "STORAGE" => "Ask at circulation desk",
   "STORBYTITL" => "Storage area: shelved by title",
   "SUL-BIND" => "At bindery",
   "SULBIND-WA" => "Not available right now",
   "SUL-LOAN" => "Ask at circulation desk",
   "TAN-LOAN" => "Philosophy Library (Tanner) circulation desk",
   "TANN-RESV" => "On reserve at Philosophy Library (Tanner)",
   "TAUBE" => "Taube Collection (non-circulating)",
   "TECH-ACQ" => "In Tech Services",
   "TECH-CAT" => "In Tech Services",
   "TECH-CONS" => "In Tech Services",
   "TECH-DESK" => "The Tech Desk",
   "TECH-PROC" => "In Tech Services",
   "TECH-RPTS" => "Technical Reports",
   "TECH-SER" => "In Tech Services",
   "TECH-SERV" => "In Tech Services",
   "TEMP-LL" => "Not available right now",
   "TEMP-LOC" => "Ask at circulation desk",
   "THEA-STOR" => "Theatre Collection storage (non-circulating)",
   "THEATRE" => "Theatre Collection (non-circulating)",
   "THESES" => "Theses",
   "TIMO-COLL" => "Timoshenko Collection (non-circulating): ask at circulation desk",
   "TINY" => "Miniature",
   "TRES-LAIR" => "Tresidder LAIR",
   "TURKISH" => "Turkish",
   "UARCH-30" => "University Archives",
   "U-ARCHIVES" => "University Archives: request at Special Collections service desk",
   "UARCH-REF" => "University Archives reference (non-circulating)",
   "UARCH-STOR" => "University Archives storage (non-circulating)",
   "UARCHX" => "University Archives: restricted access",
   "UARCHX-30" => "University Archives",
   "UNCAT" => "Uncataloged",
   "UNDERGRAD" => "Undergraduate Collection",
   "UNKNOWN" => "Unknown",
   "US-LOCAL" => "US Local Documents",
   "US-STATE" => "US State Documents",
   "VARIES" => "Ask at circulation desk",
   "VAULT" => "Vault",
   "VROOMAN" => "Vrooman Collection",
   "WEST-7B" => "Ask at circulation desk"}

 NONCIRC_LOCS = ["2NDFLR-REF",
   "3RDFLR-REF",
   "ARTLCKL-R",
   "ARTLCKM-R",
   "ARTLCKO-R",
   "ARTLCKS-R",
   "ARTLCKL",
   "ARTLCKM",
   "ARTLCKO",
   "ARTLCKS",
   "BARCHAS",
   "BENDER",
   "BUS-ARCH",
   "BUS-COMPF",
   "BUS-LOCKED",
   "BUS-MAKENA",
   "BUSDISPLAY",
   "FELTON",
   "FELT-STOR",
   "FRECOT",
   "GUNST",
   "GUNST-30",
   "GUNST-STOR",
   "HAS-ATLAS",
   "HAS-CA",
   "HAS-DIGIT",
   "HAS-FOLIO",
   "HAS-JOURN",
   "HAS-LIT",
   "HASRC",
   "HAS-RR",
   "HAS-SU",
   "IC",
   "IC-ATLAS",
   "IC-CDROM",
   "IC-DESK",
   "IC-NEWS",
   "IC-RREF",
   "IC-STATS",
   "LAW-SPEC",
   "MANNING",
   "MEDIEVALRM",
   "MEMLIBMUS",
   "MICROFICHE",
   "MUS-NOCIRC",
   "NEWTON",
   "RARE-BOOKS",
   "RARE-STOR",
   "RBCX",
   "REF-CHN",
   "REF-DESK",
   "REFERENCE",
   "REF-JPN",
   "REF-KOR",
   "REF-SERIAL",
   "RET-REF",
   "ROBINSON",
   "ROB-STOR",
   "RUMSEY",
   "SAFETY",
   "SCBS",
   "SSRC",
   "SSRC-ANRPT",
   "SSRC-ATLAS",
   "SSRC-CURR",
   "SSRC-DATA",
   "SSRC-DESK",
   "SSRC-DOCS",
   "SSRC-FICHE",
   "SSRC-FILM",
   "SSRC-SSDS",
   "STK-NOCIRC",
   "TAUBE",
   "THEA-STOR",
   "THEATRE",
   "TIMO-COLL"]

 NONCIRC_PAGE_LOCS = ["FELTON-30",
   "PAGE-AR",
   "PAGE-AS",
   "PAGE-BI",
   "PAGE-CH",
   "PAGE-CL",
   "PAGE-EA",
   "PAGE-ED",
   "PAGE-EN",
   "PAGE-ES",
   "PAGE-GR",
   "PAGE-HA",
   "PAGE-HP",
   "PAGE-HV",
   "PAGE-LW",
   "PAGE-MA",
   "PAGE-MD",
   "PAGE-MU",
   "PAGE-MY",
   "PAGE-PH",
   "PAGE-SP",
   "PAGE-TA",
   "RBC-30",
   "RBCX-30",
   "UARCH-30",
   "U-ARCHIVES",
   "UARCH-REF",
   "UARCH-STOR",
   "UARCHX",
   "UARCHX-30"]

 UNAVAILABLE_LOCS = ["ASSMD-LOST",
   "AT-REPAIR",
   "AVAIL_SOON",
   "B&F-HOLD",
   "BILLED-OD",
   "BINDERY",
   #"CHECKEDOUT",
   'CHKD-OUT-D',
   "CPM-HOLDS",
   "EDI",
   "ENDPROCESS",
   "HMS-PAGE",
   "HMS-RETURN",
   "HV-TRANS",
   "ILL",
   "ILL-OFFICE",
   "INPROCESS",
   "INSHIPPING",
   "INTRANSIT",
   "LAW-BIND",
   "LOST-ASSUM",
   "LOST-CLAIM",
   "LOST-PAID",
   "MISSING",
   "MISS-INPRO",
   "ON-ORDER",
   "PAGE-ILL",
   "PAGE-JA",
   "PAGE-LN",
   "PAGE-RLCP",
   "PGDFROMSAL",
   "PUB-TECH",
   "REPAIR",
   # removing SAL-PAGE from unavailable locations per Vitus' request
   #"SAL-PAGE",
   "SAL-RETURN",
   "SEE-ARCHIV",
   "SEE-EASTA",
   "SUL-BIND",
   "SULBIND-WA",
   "TECH-ACQ",
   "TECH-CAT",
   "TECH-CONS",
   "TECH-PROC",
   "TECH-SER",
   "TECH-SERV",
   "TEMP-LL"]

 REQUEST_LIBS = ["SAL", "SAL3", "SAL-NEWARK"]

 LOCATION_LEVEL_REQUEST_LOCS = ["SSRC-DATA"]

 REQUEST_LOCS = ["GUNST-30",
   "FELTON-30",
   "RBC-30",
   "RBCX-30",
   "UARCH-30",
   "UARCHX-30",
   "MEDIA-30",
   "MEDIAX-30",
   "MSS-30",
   "STACKS-30",
   "AT-REPAIR",
   "AVAIL_SOON",
   "B&F-HOLD",
   "BILLED-OD",
   "BINDERY",
   #"CHECKEDOUT",
   "EDI",
   "ENDPROCESS",
   "INPROCESS",
   "INSHIPPING",
   "PAGE-IRON",
   "PUB-TECH",
   "REPAIR",
   "SAL-RETURN",
   "SUL-BIND",
   "SULBIND-WA",
   "TECH-ACQ",
   "TECH-CAT",
   "TECH-CONS",
   "TECH-PROC",
   "TECH-SER",
   "TECH-SERV",
   "TEMP-LL",
   "MSSX-30"]

 REQUESTABLE_CURRENT_LOCS = [
     "MISSING",
     "NEWBOOKS",
     "ON-ORDER"
   ]
 FORCE_AVAILABLE_CURRENT_LOCS = [
   "ART-AT-ENG",
   "IC-DISPLAY"
   ]

 FORCE_NONCIRC_CURRENT_LOCS = [
   "NEWBOOKS"
   ]

 UNAVAILABLE_CURRENT_LOCS = ["AT-REPAIR",
   "AVAIL_SOON",
   "B&F-HOLD",
   "BILLED-OD",
   "BINDERY",
   #"CHECKEDOUT",
   "CPM-HOLDS",
   "ENDPROCESS",
   "INPROCESS",
   "INTRANSIT",
   "LOST-ASSUM",
   "MISSING",
   "ON-ORDER",
   "PUB-TECH",
   "REPAIR",
   "SAL-RETURN",
   "SUL-BIND",
   "SULBIND-WA",
   "TECH-ACQ",
   "TECH-CAT",
   "TECH-CONS",
   "TECH-PROC",
   "TECH-SER",
   "TECH-SERV",
   "TEMP-LL"]
 NON_REQUESTABLE_CURRENT_LOCS = [
     "ART-AT-ENG",
     "IC-DISPLAY",
     "LAC",
     "SEE-LOAN"
   ]
 NON_REQUESTABLE_HOME_LOCS = [
     "SEE-OTHER"
   ]
 HIDE_DUE_DATE_CURRENT_LOCS = [
     "ART-AT-ENG",
     "IC-DISPLAY",
     "NEWBOOKS",
     "SEE-LOAN"
   ]

 CURRENT_HOME_LOCS = [
     "ART-RESV",
     "BIO-RESV",
     "BUS-RESV",
     "BRAN-RESV",
     "CHEM-RESV",
     #"E-RESV", We need to figure out what to do w/ the pseudo eReserve library before enabling this
     "EARTH-RESV",
     "EAS-RESV",
     "EDU-RESV",
     "ENG-RESV",
     "GREEN-RESV",
     "GSB-RESV",
     "HAS-NEWBK",
     "HOOV-RESV",
     "HOP-RESV",
     "IC-DISPLAY",
     "LANE-RESV",
     "LANG-RESV",
     "LAW-RESV",
     "LOAN-DESK",
     "MATH-RESV",
     "MEDIA-RESV",
     "MEYER-RESV",
     "MUSIC-RESV",
     "PHYS-RESV",
     "RESV-DESKS",
     "RESERVES",
     "SEE-LOAN",
     "TANN-RESV",
     "SSRC-NEWBK"
   ]

 RESERVE_DESKS = {
   "ART-RESV" => "ART",
   "BIO-RESV" => "BIOLOGY",
   "CHEM-RESV" => "CHEMCHMENG",
   "E-RESV" => "SW-E-RESV",
   "EARTH-RESV" => "EARTH-SCI",
   "EAS-RESV" => "EAST-ASIA",
   "EDU-RESV" => "EDUCATION",
   "ENG-RESV" => "ENG",
   "GREEN-RESV" => "GREEN",
   "HOOV-RESV" => "HOOVER",
   "HOP-RESV" => "HOPKINS",
   "LAW-RESV" => "LAW",
   "MATH-RESV" => "MATH-CS",
   "MEDIA-RESV" => "SW-MEDIA-RESV",
   "MUSIC-RESV" => "MUSIC"
 }

 LIB_TRANSLATIONS = {#"APPLIEDPHY" => "Applied Physics Dept",
   "ARS" => "Archive of Recorded Sound",
   "ART" => "Art & Architecture Library",
   "BIOLOGY" => "Biology Library (Falconer)",
   "CHEMCHMENG" => "Chemistry & ChemEng Library (Swain)",
   "CLASSICS" => "Classics Library",
   #"CPM" => "Obsolete",
   "EARTH-SCI" => "Earth Sciences Library (Branner)",
   "EAST-ASIA" => "East Asia Library",
   "EDUCATION" => "Education Library (Cubberley)",
   "SW-E-RESV" => "eReserve", # Library does not exist, this is an internal code used for reserves.
   "ENG" => "Engineering Library (Terman)",
   "GOV-DOCS" => "Green Library",
   "GREEN" => "Green Library",
   "GRN-REF" => "Green Library",
   "HOOVER" => "Hoover Library",
   "HOPKINS" => "Marine Biology Library (Miller)",
   "HV-ARCHIVE" => "Hoover Archives",
   #"ILB" => "Ignore",
   "LANE-MED" => "Medical Library (Lane)",
   "LATHROP" => "Lathrop Library",
   "LAW" => "Law Library (Crown)",
   "BUSINESS" => "Business Library",
   "JACKSON" => "Business Library",
   "MATH-CS" => "Math & Statistics Library",
   "SW-MEDIA-RESV" => "Media & Microtext Center", # Library does not exist, this is an internal code used for reserves.
   "MEYER" => "Meyer Library",
   "MUSIC" => "Music Library",
   #"PHYSICS" => "Stanford University Libraries",
   "SAL" => "SAL1&2 (on-campus shelving)",
   "SAL3" => "SAL3 (off-campus storage)",
   "SAL-NEWARK" => "SAL Newark (off-campus storage)",
   "SPEC-COLL" => "Special Collections",
   #"SPEC-DESK" => "(In-transit location for SAL paged items)",
   "TANNER" => "Philosophy Library (Tanner)",
   "ZOMBIE" => "Stanford University Libraries"
   #"SUL" => "Stanford University Libraries"
   }
   TRANSLATE_STATUS = {
     "available" => "Available",
     "page" => "Available",
     "unavailable" => "Unavailable",
     "noncirc" => "In-library use",
     "unknown" => "Unknown",
     "noncirc_page" => "In-library use"
   }
   HIDE_1ST_IND = %W(760 762 765 767 770 772 773 774 775 776 777 780 785 786 787)
   HIDE_1ST_IND0 = %W(541 542 561 583 590)
   CONTACT_INFO = {
     :email=>"infocenter@stanford.edu",
     :website=>{:label=>"SearchWorks",:url=>"http://searchworks.stanford.edu"},
     :libraries=>[
       ["Green Library","650 725 1064"],
       ["Meyer Library (Academic Computing)","650 723 2434"],
       ["Green Library","650 725 1064"],
       ["Art & Architecture Library","650 723 3408"],
       ["Biology Library (Falconer)","650 723 1528"],
       ["Business Library","650 723 2162"],
       ["Chemistry and Chemical Engineering Library (Swain)","650 723 9237"],
       ["Classics Library","650 723 0479"],
       ["Earth Sciences Library (Branner)","650 723 2746"],
       ["East Asia Library","650 725 3435"],
       ["Education Library (Cubberley)","650 723 2121"],
       ["Engineering Library (Terman)","650 723 0001"],
       ["Hoover Institution Library","650 723 2058"],
       ["Hoover Institution Archives","650 723 3563"],
       ["Law Library (Crown)","650 723 2477"],
       ["Map Collections (Branner Library)","650 725 1103"],
       ["Marine Biology Library (Miller at Hopkins Marine Station)","831 655 6229"],
       ["Math & Statistics Library","650 723 4672"],
       ["Medical Library (Lane)","650 723 6831"],
       ["Music Library","650 723 1211"],
       ["Archive of Recorded Sound","650 723 9312"],
       ["Philosophy Library (Tanner)","650 723 1539"],
       ["Special Collections","650 725 1022"],
       ["Stanford Auxiliary Library (SAL1&2)","650 723 9201"],
       ["SLAC National Accelerator Laboratory Library","650 926 2411"]
     ]
     #No Physics or Meyer (ACOMP) in doc provided, the show up on web
   }

   HOURS_LOCATIONS = {
    "GREEN" => "green/location/green_library",
    "SAL" => "sal12/location/sal12_library",
    "MEYER" => "meyer/location/meyer_24_hour",
    "ARS" => "ars/location/ars_archive",
    "ART" => "art/location/art_library",
    "BIOLOGY" => "biology/location/biology_library",
    "CHEMCHMENG" => "chemistry/location/chemistry_library",
    "EARTH-SCI" => "earth_sciences/location/earth_sciences_library",
    "EAST-ASIA" => "east_asia/location/east_asia_library",
    "EDUCATION" => "education/location/education_library",
    "ENG" => "engineering/location/engineering_library",
    "HOPKINS" => "marine_biology/location/marine_biology_library",
    "MATH-CS" => "math_stats/location/math_stats_library",
    "MUSIC" => "music/location/music_library",
    "SPEC-COLL" => "special_collections/location/spec_coll_reading",
    "BUSINESS" => "business/location/business_library",
    "HV-ARCHIVE" => "hoover_archives/location/hv_archives",
    "HOOVER" => "hoover_library/location/hv_library",
    "LATHROP" => "meyer/location/meyer_2nd_floor",
    "LAW" => "law/location/law_library",
    "LANE-MED" => "medical/location/medical_library",
    "SLAC" => "slac/location/slac"
   }

   LIBRARY_ABOUT = {
    "ARS" => "http://library.stanford.edu/libraries/ars/about",
    "ART" => "http://library.stanford.edu/libraries/art/about",
    "BIOLOGY" => "http://library.stanford.edu/libraries/falconer/about",
    "BUSINESS" => "http://library.stanford.edu/libraries/business/about",
    "CHEMCHMENG" => "http://library.stanford.edu/libraries/swain/about",
    "EARTH-SCI" => "http://library.stanford.edu/libraries/branner/about",
    "EAST-ASIA" => "http://library.stanford.edu/libraries/eal/about",
    "EDUCATION" => "http://library.stanford.edu/libraries/cubberley/about",
    "ENG" => "http://library.stanford.edu/libraries/englib/about",
    "GREEN" => "http://library.stanford.edu/libraries/green/about",
    "HOOVER" => "http://library.stanford.edu/libraries/hoover/about",
    "HOPKINS" => "http://library.stanford.edu/libraries/hopkins/about",
    "HV-ARCHIVE" => "http://library.stanford.edu/libraries/hila/about",
    "LATHROP" => "http://library.stanford.edu/libraries/lathrop/about",
    "LAW" => "http://library.stanford.edu/libraries/law/about",
    "LANE-MED" => "http://library.stanford.edu/libraries/lane/about",
    "MATH-CS" => "http://library.stanford.edu/libraries/mathstat/about",
    "MUSIC" => "http://library.stanford.edu/libraries/music/about",
    "MEYER" => "http://library.stanford.edu/libraries/meyer/about",
    "TANNER" => "http://library.stanford.edu/libraries/philosophy/about",
    "SPEC-COLL" => "http://library.stanford.edu/libraries/spc/about",
    "SAL" => "http://library.stanford.edu/libraries/sal/about",
    "SAL-NEWARK" => "http://library.stanford.edu/libraries/newark/about",
    "SAL3" => "http://library.stanford.edu/libraries/sal3/about",
    "SLAC" => "http://library.stanford.edu/libraries/slac/about"
   }

   EXCLUDE_FIELDS = ["w", "0", "5", "6", "8", "?", "="]

   NIELSEN_TAGS = {"505"=>"905","520"=>"920","586"=>"986"}
   SOURCES = {"Nielsen" => "(source: Nielsen Book Data)"}
   SUL_ICONS = {
    "Object" => "cube",
    "Archive/Manuscript" => "document-box-1",
    "Article" => "text-wrapping-1",
    "Book" => "book-1",
    "Dataset" => "business-chart-1",
    "Database" => "window-search",
    "Equipment" => "plug-2",
    "Image" => "photos-1",
    "Journal/Periodical" => "book-2",
    "Map" => "map-location",
    "Music recording" => "gramophone",
    "Music score" => "file-music",
    "Newspaper" => "newspaper-2",
    "Software/Multimedia" => "mouse-2",
    "Sound recording" => "microphone-2",
    "Video" => "film-2",
    "Web Archive" => "window-selection",
    "Credits" => "contacts-1",
    "Subjects" => "tags-1",
    "Contents" => "list-4",
    "Browse" => "books-3",
    "Chat" => "bubble-2",
    "Feedback" => "mail-1",
    "Cite" => "quote",
    "Send To" => "link",
    "Selections" => "check-3"
   }
   BROWSABLE_CALLNUMBERS = ["LC", "DEWEY"]
   LIBRARY_INSTRUCTIONS = {
     "SPEC-COLL" => {
       heading: "Limited access",
       text: "All materials are stored offsite. Request items 2 business days in advance. Maximum 5 items per day."
     }
   }
end
