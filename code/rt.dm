#ifndef TESTING
//    #define FASTLOAD
//    #define DEPLOY_TEST
//    #define ROGUEWORLD
#endif

#ifdef FASTLOAD
    #define FORCE_MAP "_maps/roguetest.json"
#else
    #define FORCE_MAP "_maps/blackstone.json"
#endif

//#define WARTIME
