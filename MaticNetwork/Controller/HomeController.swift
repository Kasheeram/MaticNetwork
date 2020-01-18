//
//  HomeController.swift
//  MaticNetwork
//
//  Created by kashee kushwaha on 17/01/20.
//  Copyright © 2020 kashee kushwaha. All rights reserved.
//

import UIKit
import CoreData

class HomeController: UIViewController {
    
    let topHeadlineCellId = "topHeadlineCellId"
    
    let articleDetailsEntity = "ArticleDetails"
    let sourceDetailsEntity = "SourceDetails"
    
    var totalResult:Int?
    var topHeadlineArticles = [ArticleViewModel]()
    
    lazy var cardViewCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 15.0
        layout.minimumInteritemSpacing = 0
        let CV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        CV.register(TopHeadlineListCell.self, forCellWithReuseIdentifier: topHeadlineCellId)
        CV.delegate = self
        CV.dataSource = self
        CV.backgroundColor = .white
        return CV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Top Headlines"
        setupViews()
        getToHeadlines()
        
    }
    
    private func getToHeadlines() {
        let stringUrl = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=3e5053e7e22b4a71a9b788b6a5a6001e"
        Service.shared.fetchGenericData(urlString: stringUrl) { (res:Swift.Result<TopHeadlines, Error>) in
            switch res {
            case .success(let headlines):
                if let articles = headlines.articles, let totalResult =  headlines.totalResults {
                    self.totalResult = totalResult
                    self.topHeadlineArticles += articles.map({ return ArticleViewModel(article: $0)})
                    
                    if self.topHeadlineArticles.count > 0 {
                        self.saveDataToCoreData(topHeadlines: self.topHeadlineArticles)
                    }
                }
                self.cardViewCollection.reloadData()
                
            case .failure(let err):
                switch err {
                case errorMessages.noInternet:
                    self.readArticleFromLocal()
                default:
                    print(err)
                }
                
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(cardViewCollection)
        cardViewCollection.fillSuperview()
        
        
    }
    
    func saveDataToCoreData(topHeadlines: [ArticleViewModel]) {
        // First delete existing data and the store latest
        self.deleteLocalData()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        for article in topHeadlines {
            let articleDtl = NSEntityDescription.insertNewObject(forEntityName: articleDetailsEntity, into: context) as! ArticleDetails
            articleDtl.author = article.author
            articleDtl.title = article.title
            articleDtl.url = article.url
            articleDtl.urlToImage = article.urlToImage
            articleDtl.publishedAt = article.publishedAt
            articleDtl.descriptions = article.description
            articleDtl.content = article.content
            
            let sourceDtl = NSEntityDescription.insertNewObject(forEntityName: sourceDetailsEntity, into: context) as! SourceDetails
            sourceDtl.id = article.source?.id
            sourceDtl.name = article.source?.name
            articleDtl.sourceDetails = sourceDtl
            
            do {
                try context.save()
            } catch let err {
                print(err)
            }
        }
        
    }
    
    private func readArticleFromLocal() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleDetails")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request) as? [ArticleDetails]
            guard let results = result else { return }
            if (results.count) > 0 {
                for result in results {
                    //                    print(result.descriptions)
                    let article = Article(source: Source(id: result.sourceDetails?.id, name: result.sourceDetails?.name), author: result.author, title: result.title, description: result.descriptions, url: result.url, urlToImage: result.urlToImage, publishedAt: result.publishedAt, content: result.content)
                    topHeadlineArticles.append(ArticleViewModel(article: article))
                }
                self.cardViewCollection.reloadData()
            }
        } catch let err {
            print(err)
        }
        
    }
    
    
    private func deleteLocalData() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        var context:NSManagedObjectContext?
        context = appDelegate?.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: articleDetailsEntity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            try context?.execute(deleteRequest)
            try context?.save()
            print ("Dashboard information is deleted")
        } catch {
            print ("There is an error in deleting records")
        }
    }
    
    
}





extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topHeadlineArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topHeadlineCellId, for: indexPath) as! TopHeadlineListCell
        let articleDetails = topHeadlineArticles[indexPath.row]
        cell.article = articleDetails
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let articleDetails = topHeadlineArticles[indexPath.row]
        
        let articalDetailsVC = ArticalDetailsController()
        articalDetailsVC.articalViewModel = articleDetails
        navigationController?.pushViewController(articalDetailsVC, animated: true)
    }
    
    
}
