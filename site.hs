-----------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
import qualified Data.Set as S
import qualified Data.Map as M
import           Text.Pandoc.Options
import Data.List (isSuffixOf)
import System.FilePath (takeDirectory, (</>), takeBaseName, splitExtension, splitFileName, (<.>))
--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["about.md", "notes.md", "texts.md", "cities.md"]) $ do
        route   $ setExtension "html" `composeRoutes`
                appendIndex
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "files/*" $ do
    	route   idRoute
	compile copyFileCompiler

    match "images/*" $ do
    	route   idRoute
	compile copyFileCompiler

    match "posts/*" $ do
        route $ setExtension "html"
        let writerOptions = defaultHakyllWriterOptions
                    { writerHTMLMathMethod = MathJax "" }
        compile $ pandocCompilerWith defaultHakyllReaderOptions writerOptions
            >>= loadAndApplyTemplate "templates/post.html" postCtx
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    match "notes/*" $ do
        route $ setExtension "html" `composeRoutes`
	        dropNotesPrefix         `composeRoutes`
		appendIndex
        let writerOptions = defaultHakyllWriterOptions
                    { writerHTMLMathMethod = MathJax "" }
        compile $ pandocCompilerWith defaultHakyllReaderOptions writerOptions
            >>= loadAndApplyTemplate "templates/post.html"    postCtx 
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    match "index.md" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "templates/*" $ compile templateCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    dropIndexHtml "url"          `mappend`
    defaultContext
--------------------------------------------------------------------------------
config :: Configuration
config = defaultConfiguration
    { destinationDirectory = "docs"
    }

----

dropIndexHtml :: String -> Context a
dropIndexHtml key = mapContext transform (urlField key) where
    transform url = case splitFileName url of
                        (p, "index.html") -> takeDirectory p
			_                 -> url

------------------------------------------------------

dropNotesPrefix :: Routes
dropNotesPrefix = gsubRoute "notes/" $ const ""


----------------

appendIndex :: Routes
appendIndex = customRoute $ 
    (\(p, e) -> p </> "index" <.> e) . splitExtension . toFilePath

---
