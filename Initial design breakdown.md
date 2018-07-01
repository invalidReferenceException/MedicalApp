# GUI breakdown by Environment

## Login
    - background view
        - assets: stock/launch screen image
    - login view (**centered horizontally and vertically**)
        - app name image (**centered horizontally**) 
            - assets: app name graphics
        - login (**padding 1/10th of view left and right**, space between controls is about 30pts, error message about 10 pts from email input)
            - incorrect email or password
                - assets: conditional message label, communicating style change to input (styler), affected by authentication clearance tool
            - login input (styler)
                - text field input
                    - assets: email input, email format check (tool), placeholder,email logo, style affected by incorrect email or password
                - secure text field input
                    - assets: secure password input, password check (tool), placeholder, password logo, style affected by incorrect email or password
            - sign in button
                - assets: linked to authentication clearance (tool), linked to home transition (navigation)
            - forgot password button
                - assets: none/dummy link
## Home
    - main view (navigation style view homepage)
        - header
            - app name image (**centered horizontally**)
                - assets: app name graphics
            - alerts/notification (**second right side**)
                - assets: dynamic alert icon with number of alerts (dynamic data), linked to alerts view (navigation)
            - physician account button (**right side**)
                - assets: physician picture (database data), downward arrow icon, linked to physician account settings/authentication (navigation)
        - table view
            - welcome section (no header)
                - welcome title label
                        - assets: physician name (database data)
                - welcome tagline label
            - search section (text and icon button styler)
                - search section headline
                - search by name or id view
                    - icon button
                        - assets: patient name or id icon
                    - text button
                        - search based on tagline label
                        - name or id title label 
                    - assets: linked to search (navigation)
                - or label
                - search by bar code view
                    - icon button
                        - assets: patient code icon
                    - text button
                        - search based on tagline label
                        - scan patient code title label
                    - assets: linked to scanner (navigation)
            - browse section (button styler)
                - browse section headline
                - recently viewed button (navigation)
                    assets: background image, label, number of recently viewed (10 by default)
                - your attending button (navigation)
                    assets: background image, label, number of physician attendings (database data)
                - your ordered button (navigation)
                    assets: background image, label, number of tests ordered by physician (database data)
                - your admitted button (navigation)
                    assets: background image, label, number of patients admitted by physician (database data)      
## Scan
    - camera view
        - header
            - cancel/back button (navigation)
            - scan patient code title label
        - camera feed
            - barcode outliner blue rectangle
                - assets: coordinates given by barcode detection from camera feed (tool)
            - status message label
                - assets: status message (detecting vs. scan completed) given by status of barcode detection from camera feed (tool)
            - assets: ios camera feed
        - dummy connector to search result for user code in search view (navigation)
## Search
    - header
        - cancel/back button
        - search input
            assets: placeholder, search logo, search(tool)
    - table view
        - recent
            - recent header label
            - recent list view
                - assets: recently searched patient names/ids (dynamic app data; 10 items by default) gathered on selection of result searched(so as to not have plenty of recent wrong searches or half-typed searches.) (tool)
        - search results
            - table header labels by column
            - searched users: test list cells (prototype cell styler)
                - patient name title + id tagline label
                - patient date of birth label
                - test protocol title + type tagline
                - test status icon + label
                - estimated completion label
                - assets: test status icons, patient biographical and test data (database data) according to results of search by patient name or id (tool) (dynamic data), select to go to test view (navigation)
## Browse
    - header
        - navigation bar (##HOME HEADER + a cancel button)
            - back button
        - tabs (navigation) (styler)
            - recently viewed tab button
            - attending tab button
            - ordered tab button
            - admitted tab button
        - selected tab header
            - recently viewed(last 10) (tool), Attending, Ordered, Admitted selected label with dynamic number of list results (database data)
            - sorting filter by attribute (tool)
                - sort by label
                - filter dropdown menu (last updated, patient name, date of birth) (navigation)
        - search results prepped by browser (tool) (##SEARCH SEARCH RESULTS but with a different data provider (tool): browser instead of search)

## Test Info
    - all in a vertical scroll view (even the navigation bar)
    - navigation bar (##BROWSE HEADER but with a different title text label (not app name image graphic))
    - test basic info header
        - patient name tagline + title label
        - patient id tagline + title label
        - patient location tagline + title label
        - date of birth tagline + title label
        - test protocol tagline + title label
        - test type tagline + title label
        - test source tagline + title label
        - alerts preferences button (navigation)
            - assets: alerts icon (black deactivated, red while selecting alerts), link to toggle subscription to test phases alerts for test displayed (tool)
    - testing status
        - general timeline summary
            - estimated date and time for final AST phase title label
            - latest update timestamp tagline label 
        - phases timeline (navigation)
            - connecting line
            - individual phase node (current test phase retrieval(tool))
                - phase dynamic circle
                    - assets: green check icon, dependent on active phase + alert icon and button for alert mode (in alert selection mode: grey check when phase is done, black bell when notification is not turned on, red bell with sound waves and slightly bigger circle and icon when it's turned on)
                - phase title label
                - phase estimated time of completion tagline label
                - triangle tooltip (with same shadow as rest of separator)
            - separator line with shadow on the bottom side
        - individual phase timeline table view (navigation)
            - phase section title
            - individual phase step cell 
                - step name label + timestamp label
    - targeted antibiotic suggestions collection view (navigation)
        - antibiotic group item
            - group name label
            - dynamic chart
                - chart
                    - x axis bar with initial and final values
                    - gram positive bacteria with percentage coverage for antibiotic in specified antibiotic group in y positive in bar or scatter, if any
                    - gram negative bacteria with percentage coverage for antibiotic in specified antibiotic group in y negative; if any
                - slider (navigation)
                    - vertical line to select x value
                    - highlight with stronger color scatter dots/bars with that x value
                - tooltip (when x value on chart selected) (navigation)
                    - percent coverage (x value) title label
                    - gram positive title label. Conditional to If there are any gram positive matches
                    - gram negative title label. Conditional to If there are any gram negative matches
                    - collection view (gram positive column if any + gram negative column if any)
                        - matching bacteria title label
                        - linking antibiotic name + cost tagline
            - table view
                - antibiotic cell (different spacing between columns/items and different background colors available)
                    - antibiotic name label 
                    - cost level icon
                    - additional info dots icon
                    - colored match percentage label with a strand of bacteria (for as many bacteria as supplied/ optional)
                    - dosage suggestion label (optional)
                - potential last row disclaimer cell on group
    - antibiotic reference table view horizontal scroll view (navigation)
        - header
            - systemic title column label
            - gram positive bacteria column group/section label
            - gram negative bacteria column group/section label
            - bacteria column labels 
        - table view (tap to modal)
            - antibiotic group
            - antibiotic cell (like in targeted antibiotic suggestions collection view)
    - footer
        - antibiotic details legend list
            - additional info dots icon
            - color description label
        - comments
            - comment section table view
                - comments section header title
                - comment cell
                    - author physician tooltip
                        - thumbnail account picture
                        - name title label
                        - organization tagline label
                    - comment date tooltip
                    - comment text view
                - input comment cell (navigation) (like comment cell but with input view instead of normal text view and save or cancel options.)
            - add comment button (navigation)
                -button label 
                    - assets: linked to comment section table view to prop up input comment cell. It becomes save/cancel buttons.
            - assets: input/output to data structure (tool)
    - modal selected antibiotic group reference table (preserve proportion, translucent background, tap outside of modal to dismiss) (navigation)
        - antibiotic reference table header
        - antibiotic table view for selected group
        - footer antibiotic details legend list.


(gui pieces,)
data structures (physician account, (which owns through relation) patient profile,(which owns through relation) test profile (including comments), (which owns through relation but actually also owned by specific physician) phase alerts),
navigation pieces (get/dismiss views, animation, touches),
back-end tools (fetch data from json database, alert settings)


# Tools

## email format check (tool)
    - check for non-null
    - check for email format correctedness (@, . after at least 1 character after @)
## password check (tool)
    - check for non-null
## linked to authentication clearance (tool)
    - check for email/password combo in plist file
    - if found execute navigation to home (navigation)
    - if not found execute error view
## camera feed barcode scanner (tool) (API: AVFoundation)
    - get camera feed
    - call barcode recognizer
    - if recognizer gets valid output (can add constraints to what is valid output we want)
        - initiate search navigation 
        - with output as query
## search patient tests by query (tool)
    - ask for database content object to database manager
    - query the object by one specific attribute only (patient ID, patient name, browsing options attributes(by physician attendings, by tests ordered, by patients admitted,recent))
    - passing query data to caller
    - query object
        - holds latest query until a new one is asked
## search sorting order by attribute (tool)
    - order tuple/multidimensional array by attribute
## recent (10) tests viewed by user (tool) (API: JSONEncoder, Encodable)
    - when new test is sent to this tool you encode it in JSON
    - you send it to the JSON file for the user/physician
## test phase alert subscription and notification service(tool) (API: JSONEncoder, Encodable, JSONDecoder, Decodable)
    - when test phase subscription is sent encode it in JSON
    - when test phase is unsubscribed from delete record from JSON
    - every so often check for new test phase data
        - query your own JSON database of subscriptions for physician
            - for each search database to see if phase is now done
            - if yes write notification message with text and phase
                - add to queue of active notifications
    - maintain live record to active notifications (up to last 10)
## retrieve current test data
    - retrieve data for one test from the query object
    - pass patient test object to the caller
        - patient test object
## retrieve test phase (tool)
    - pass current test phase of test object to caller
## antibiotic suggestion
    - NO NEED! PATIENT TEST PHASE DATA INCLUDES ALL SUGGESTION DATA THERE IS NO MATCHING TO BE DOME WITH REFERENCE TABLE. THE SERVER DOES ALL THE SUGGESTION LOGIC WE ONLY DISPLAY IT WITH NO LOGIC TO BE DONE
## comments input/output in data structure (tool) (API: JSONEncoder, Encodable, JSONDecoder, Decodable)
    - retrieve comments from database manager and return them to caller
    - take comment data and pass it to database for encoding

# Navigation

## alerts button popover (navigation)
## physician account button popover (navigation)
## launch screen -> home (navigation)
## homepage -> search view (navigation)
## homepage -> scanner view (navigation)
## scanner -> search view search results (navigation)
## homepage -> specific browse view tab (navigation)
## navigation cancel button camera feed/search/browse (different back button icon/ back not cancel) -> homepage (navigation)
## test item cell -> test view (navigation)
## browse tabs switcher (navigation)
## search filter dropdown (navigation)
## test phase tabs choice mandated by test data (navigation)
## phase alerts setup (navigation)
## modal antibiotic reference table (navigation)
## heatmap selection slider (navigation)
## heatmap selection popover (navigation)
## test comment entry (navigation)


# Stylers

## app color palette
## launch screen normal and alert (styler)
## homepage header (styler)
## homepage search text and icon button (styler)
## homepage browse button (styler)
## search/browse prototype cell (styler)
## browse tabs buttons (styler)
## test bio data labels (styler)
## test phase tabs buttons (styler)
## test phase alert buttons (styler)
## test phase summary details (styler)
## heatmap (styler)
## heatmap tooltip bacteria result item (styler)
## dynamic antibiotic prototype cell (styler)
## comment (styler)

# Assets

## graphic assets
    - keep a record of locally available graphic assets
    - return to caller loaded data into appropriate data object according to 
        - file format and 
        - caller requirements
## settings 
    - keep a record of locally available .plist files
    - query .plist elements
    - give appropriate string to caller
## JSON database (API: JSONEncoder, Encodable, JSONDecoder, Decodable)
    - keep a record of locally available JSON databases
    - decode data from JSON format into Swift data structures
    - encode data to JSON format from Swift data structures


For the prototype there is only one test data for all test subjects, and there is only one data for antibiotic suggestion and reference tables at phase 1/inoculation; phase 2 takes phase 1's data for the reference table + phase 2 data for suggestions. final ID and organism AST have no reference table so all data is for the suggestions.