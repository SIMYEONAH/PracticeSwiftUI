import SwiftUI

struct GridTestView: View {
    var body: some View {
        TabView {
            StoreGridView()
                .tabItem {
                    Label("상점", systemImage: "cart")
                }
            Text("홈")
                .tabItem {
                    Label("홈", systemImage: "house")
                }
            Text("캐릭터")
                .tabItem {
                    Label("캐릭터", systemImage: "person")
                }
            Text("마이페이지")
                .tabItem {
                    Label("마이페이지", systemImage: "person.crop.circle")
                }
        }
    }
}

struct StoreGridView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(products) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductItemView(
                                iconName: product.iconName,
                                name: product.name,
                                price: product.price,
                                bgColor: product.bgColor
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
    }
}

struct ProductItemView: View {
    let iconName: String
    let name: String
    let price: Int
    let bgColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(bgColor)
                    .frame(height: 90)

                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
            }

            Text(name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.black)

            Text("\(price) 코인")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(8)
    }
}

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: product.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            Text(product.name)
                .font(.title)
                .fontWeight(.bold)

            Text("가격: \(product.price)")
                .font(.headline)

            Spacer()
        }
        .padding()
        .navigationTitle("상세보기")
    }
}

struct Product: Identifiable {
    let id = UUID()
    let iconName: String
    let name: String
    let price: Int
    let bgColor: Color
}

let products = [
    Product(iconName: "syringe", name: "주사 치료", price: 199, bgColor: .blue.opacity(0.4)),
    Product(iconName: "bandage", name: "밴드 치료", price: 159, bgColor: .yellow.opacity(0.4)),
    Product(iconName: "pill", name: "약물 치료", price: 89, bgColor: .pink.opacity(0.4)),
    Product(iconName: "tennisball", name: "캐치볼 놀이", price: 189, bgColor: .green.opacity(0.4)),
    Product(iconName: "bird", name: "힐링하기", price: 229, bgColor: .purple.opacity(0.4)),
    Product(iconName: "shippingbox", name: "랜덤박스선물", price: 209, bgColor: .orange.opacity(0.4)),
    Product(iconName: "pill", name: "약물 치료", price: 89, bgColor: .cyan.opacity(0.4)),
    Product(iconName: "tennisball", name: "캐치볼 놀이", price: 189, bgColor: .green.opacity(0.4)),
]

#Preview {
    GridTestView()
}
